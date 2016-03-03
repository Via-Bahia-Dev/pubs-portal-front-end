class WelcomeController < ApplicationController

	def index
		if signed_in?
			@templates = get("/templates")
			@requests  = get("/publication_requests")
			@statuses  = get("/statuses")
			get_tag_select_options
		end
	end
end
