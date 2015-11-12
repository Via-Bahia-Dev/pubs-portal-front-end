class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

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
			flash[:error] = "You need to be signed in to access that page"
			redirect_to root_path
		end
	end

	def show
		if signed_in?
			res = self.class.get("/users/#{params[:id]}.json", :headers => { "X-User-Email" => session[:user_email], "X-Auth-Token" => session[:auth_token] })
			if res.success?
				# @user = res.parsed_response["data"]
				@user = User.find(res.parsed_response["data"]["id"])
			else
				flash[:error] = res.parsed_response["errors"]
				redirect_to root_path
			end
		else
			flash[:error] = "You need to be signed in to access that page"
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
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		res = self.class.put("/users/#{params[:id]}.json", 
													:query => { :user => user_params },
													:headers => { "X-User-Email" => session[:user_email], "X-Auth-Token" => session[:auth_token] })
		if res.success?
			flash[:success] = "#{@user.first_name} #{@user.last_name} successfully updated!"
			redirect_to user_path(@user)
		else
			flash.now[:error] = res.parsed_response["errors"]
			render :edit
		end
	end

	private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :roles_mask)
    end
end
