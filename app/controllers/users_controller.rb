class UsersController < ApplicationController

	def index
		if signed_in?
			res = self.class.get("/users.json", :headers => { "X-User-Email" => session[:user_email], "X-Auth-Token" => session[:auth_token] })
			if res.success?
				@users = res.parsed_response["data"]
			else
				flash[:error] = res.parsed_response["errors"]
				redirect_to root_path
			end
		else
			flash[:error] = "You need to be logged in to access that page"
			redirect_to root_path
		end
	end

	def show
		if signed_in?
			res = self.class.get("/users/#{params[:id]}.json", :headers => { "X-User-Email" => session[:user_email], "X-Auth-Token" => session[:auth_token] })
			if res.success?
				@user = res.parsed_response["data"]
			else
				flash[:error] = res.parsed_response["errors"]
				redirect_to root_path
			end
		else
			flash[:error] = "You need to be logged in to access that page"
			redirect_to root_path
		end
	end

	def new
		@user = User.new
	end

	def create
		res = self.class.post("/users.json", :query => { :user => { :first_name => params[:user][:first_name], 
																																:last_name => params[:user][:last_name], 
																																:email => params[:user][:email],
																																:password => params[:user][:password] } },
																				 :headers => { "X-User-Email" => session[:user_email], "X-Auth-Token" => session[:auth_token] } )
		if res.success?
			flash[:success] = "#{res.parsed_response["data"]["first_name"]} #{res.parsed_response["data"]["last_name"]} added!"
			redirect_to users_path
		else
			flash.now[:error] = res.parsed_response["errors"]
			render 'new'
		end
	end
end
