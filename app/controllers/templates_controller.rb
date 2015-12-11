class TemplatesController < ApplicationController

	def new
		@template = Template.new
	end

	def create
		params[:template][:user_id] = current_user.id # cheating, not using api, but just getting it to work
		@template = Template.new(template_params) # This is needed for the form_for to repopulate fields
		res = self.class.post("/templates.json", :query => { :template => template_params },
																				 :headers => auth_headers, :detect_mime_type => true)
		if res.success?
			flash[:success] = "#{res.parsed_response["data"]["name"]} template uploaded!"
			redirect_to root_path
		else
			@template.save #this will get the errors in the model
			# we're actually using these errors for error messages for now, not the json from the api
			# just more convenient

			# flash.now[:error] = errors_from_json(res.parsed_response["errors"]) # old use of flash
			render :new
		end
	end

	private
    def template_params
    	params.require(:template).permit(:name, :user_id, :dimensions, :image, :link, :category)
  	end
end
