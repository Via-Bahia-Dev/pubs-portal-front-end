class PublicationRequestsController < ApplicationController

	def new
		@publication_request = PublicationRequest.new
		if params[:template_id]
			@publication_request.templates << Template.find(params[:template_id])
		end

		template_res = self.class.get("/templates/#{params[:template_id]}", :headers => auth_headers)
		if template_res.success?
			@template = template_res.parsed_response["data"]
		else
			@template = nil
		end
	end

	def create
		params[:publication_request][:user_id] = current_user.id
		@publication_request = PublicationRequest.new(publication_request_params)
		# Need to define @template as well

		res = self.class.post("/publication_requests.json", :query => { :publication_request => publication_request_params },
																				 :headers => auth_headers, :detect_mime_type => true)
		if res.success?
			flash[:success] = "Request for #{res.parsed_response["data"]["event"]} submitted!"
			redirect_to root_path
		else
			flash.now[:error] = res.parsed_response["errors"]
			render :new
		end
	end


	private

		def publication_request_params
	    params.require(:publication_request).permit(:event, :description, :dimensions, :rough_date, :due_date, :event_date, :user_id, :admin_id, :reviewer_id, :designer_id, :status)
	  end
end
