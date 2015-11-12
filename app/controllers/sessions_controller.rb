class SessionsController < ApplicationController

	def new
	end

	def create
		response = self.class.post("/sign_in.json", :query => { :user => { :email => params[:user][:email], :password => params[:user][:password] } })
		if response.success?
			session[:user_email] = response.parsed_response["user_email"]
			session[:auth_token] = response.parsed_response["auth_token"]
			redirect_to root_path
		else
			flash[:error] = "email or password was not valid!"
			redirect_to root_path
		end
	end

	def destroy
		response = self.class.delete("/sign_out.json", :headers => { "X-User-Email" => session[:user_email], "X-Auth-Token" => session[:auth_token] })

		if response.success?
			session[:user_email] = nil
			session[:auth_token] = nil
			flash[:success] = "Successfully signed out"
			redirect_to root_path
		else
			flash[:error] = "Failed to sign out"
			redirect_to root_path
		end
	end

end
