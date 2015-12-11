class WelcomeController < ApplicationController

	def index
		if signed_in?
			res = self.class.get("/templates.json", :headers => auth_headers)
			if res.success?
				@templates = res.parsed_response["data"]
			else
					flash[:error] = res.parsed_response["errors"]
					# redirect_to root_path
			end
		end
	end
end
