class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy, :update_password]

	def index
    @users = get("/users")
	end

	def show
		res = get("/users/#{params[:id]}")

		# Need to check if res is json at all.
		# If user is unauthorized to see this user, res will be unauthoraized page
		if res.include? "id"
	    @user = User.find(res["id"])
		end
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

	def update_password
		res = put("/users/#{params[:id]}/update_password", { :user => user_password_params })

		if res["errors"].nil?
			flash[:success] = "Successfully changed password"
      redirect_to user_path(params[:id])
		else
			@errors = res["errors"]
      render :show
		end
	end

	private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :roles_mask)
    end

		def user_password_params
			params.require(:user).permit(:current_password, :password, :password_confirmation)
		end
end
