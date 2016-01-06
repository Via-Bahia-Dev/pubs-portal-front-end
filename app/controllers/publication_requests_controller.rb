class PublicationRequestsController < ApplicationController

	def new
		@publication_request = PublicationRequest.new
		if params[:template_id]
			@publication_request.template_id = params[:template_id]
		end

		template_res = self.class.get("/templates/#{params[:template_id]}", :headers => auth_headers)
		if template_res.success?
			@template = template_res.parsed_response["data"]
		else
			@template = nil
		end

		admin_res = self.class.get("/users/admins", :headers => auth_headers)
		if admin_res.success?
			admins = admin_res.parsed_response["data"]
			@admins_options = admins.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }
		else
			@admins_options = [[]]
		end

		designer_res = self.class.get("/users/designers", :headers => auth_headers)
		if designer_res.success?
			designers = designer_res.parsed_response["data"]
			@designers_options = designers.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }
		else
			@designers_options = [[]]
		end

		reviewer_res = self.class.get("/users/reviewers", :headers => auth_headers)
		if reviewer_res.success?
			reviewers = reviewer_res.parsed_response["data"]
			@reviewers_options = reviewers.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }
		else
			@reviewers_options = [[]]
		end
	end

	def create
		# params[:publication_request][:user_id] = current_user.id
		@publication_request = PublicationRequest.new(publication_request_params)

		# get the template again
		template_res = self.class.get("/templates/#{params[:publication_request][:template_id]}", :headers => auth_headers)
		if template_res.success?
			@template = template_res.parsed_response["data"]
		else
			@template = nil
		end

		admin_res = self.class.get("/users/admins", :headers => auth_headers)
		if admin_res.success?
			admins = admin_res.parsed_response["data"]
			@admins_options = admins.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }
		else
			@admins_options = [[]]
		end

		designer_res = self.class.get("/users/designers", :headers => auth_headers)
		if designer_res.success?
			designers = designer_res.parsed_response["data"]
			@designers_options = designers.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }
		else
			@designers_options = [[]]
		end

		reviewer_res = self.class.get("/users/reviewers", :headers => auth_headers)
		if reviewer_res.success?
			reviewers = reviewer_res.parsed_response["data"]
			@reviewers_options = reviewers.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }
		else
			@reviewers_options = [[]]
		end
		# We need the ActiveRecord of the model in order to add it to the Publication Request association
		# @publication_request.templates << Template.find(params[:publication_request][:template_id])
		# we merge in a list of the Template model in order to build the association on create
		res = self.class.post("/publication_requests", :query => { :publication_request => publication_request_params },
																				:headers => auth_headers, :detect_mime_type => true)
		if res.success?
			flash[:success] = "Request for #{res.parsed_response["data"]["event"]} submitted!"
			redirect_to root_path
		else
			@publication_request.save
			@errors = res.parsed_response["errors"]
			render :new
		end
	end


	private

		def publication_request_params
	    params.require(:publication_request).permit(:event, :description, :dimensions, :rough_date, :due_date, :event_date, :admin_id, :reviewer_id, :designer_id, :status, :template_id)
	  end
end
