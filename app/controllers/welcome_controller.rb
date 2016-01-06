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

			requests_res = self.class.get("/publication_requests", :headers => auth_headers)
			if requests_res.success?
				@requests = requests_res.parsed_response["data"]
			else
				flash[:error] = requests_res.parsed_response["errors"]
			end
		end
	end
end
