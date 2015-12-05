class TemplatesController < ApplicationController

	def new
		@template = Template.new
	end

	def create
		res = self.class.post("/templates.json", :query => { :template => template_params },
																				 :headers => auth_headers )
		if res.success?
			flash[:success] = "#{res.parsed_response["data"]["name"]} template uploaded!"
			redirect_to root_path
		else
			flash.now[:error] = res.parsed_response["errors"]
			render :new
		end
	end

	private
    def template_params
    	params.require(:template).permit(:name, :user_id, :dimensions, :image, :link, :category)
  	end
end
