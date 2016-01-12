class WelcomeController < ApplicationController

	def index
		if signed_in?
			@templates = get("/templates")
			@requests = get("/publication_requests");
		end
	end
end
