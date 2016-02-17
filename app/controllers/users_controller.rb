class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
    @users = get("/users")
	end

	def show
    @user = User.find(get("/users/#{params[:id]}")["id"])
	end

	def new
		@user = User.new
	end

	def create
		res = post("/users.json",{ :user => user_params })
		if res["errors"].nil?
			flash[:success] = "#{res["first_name"]} #{res["last_name"]} added!"
			redirect_to users_path
		else
			flash.now[:error] = res["errors"]
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		res = put("/users/#{params[:id]}", { :user => user_params })
		if res["errors"].nil?
			if request.xhr?
				head :no_content
			else
				flash[:success] = "#{@user.first_name} #{@user.last_name} successfully updated!"
				redirect_to users_path
			end
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
