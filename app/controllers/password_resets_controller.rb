class PasswordResetsController < ApplicationController
  def new
  end

  def create
    # user = get("/users/show", { :user => params[:email] })
    post("/password_resets", { :email => params[:email] })
    flash[:success] = "Email sent with password reset instructions"
    redirect_to root_url
  end

  def edit
    # this is just needed for the form_for
    @user = User.find_by(:password_reset_token => params[:id])
  end

  def update
    byebug
    res = put("/password_resets/#{params[:id]}", { :user => params[:user]})

    if res["errors"].nil?
      flash[:success] = "Password has been reset!"
      redirect_to root_url
    else
      # this is just needed for the form_for
      @user = User.find_by(:password_reset_token => params[:id])
      @errors = res["errors"]
      render :edit
    end
  end

end
