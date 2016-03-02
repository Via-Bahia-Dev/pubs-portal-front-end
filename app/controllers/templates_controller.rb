class TemplatesController < ApplicationController

	def index
		@templates = get("/templates")
		get_tag_editable_select_options
	end

	def new
		@template = Template.new
		get_tag_select_options
	end

	def create
		params[:template][:user_id] = current_user.id # cheating, not using api, but just getting it to work
		@template = Template.new(template_params) # This is needed for the form_for to repopulate fields
		res = post("/templates.json", { :template => template_params })
		if res["errors"].nil?
			flash[:success] = "#{res["name"]} template uploaded!"
			redirect_to root_path
		else
			@template.save #this will get the errors in the model
			get_tag_select_options
			# we're actually using these errors for error messages for now, not the json from the api
			# just more convenient

			# flash.now[:error] = errors_from_json(res.parsed_response["errors"]) # old use of flash
			render :new
		end
	end

	def update
		res = put("/templates/#{params[:id]}", {:template => template_params})
		if res["errors"].nil?
			head :no_content
		end
	end

	def destroy
		res = delete("/templates/#{params[:id]}")

    if res['errors'].nil?
      head :no_content
    else
      flash[:errors] = res['errors']
      redirect_to templates_path
    end
	end

	private
    def template_params
    	params.require(:template).permit(:name, :user_id, :dimensions, :image, :link, :category, :all_tags => [])
  	end
end
