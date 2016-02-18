class PasswordsController < ApplicationController

  def create
    @user = User.find(params[:change_password_form][:user_id])
    @pass_form = ChangePasswordForm.new(@user)
    if @pass_form.submit(params[:change_password_form])
      flash[:success] = "Successfully changed password"
      redirect_to user_path(@user)
    else
      flash[:error] = @pass_form.errors
      redirect_to user_path(@user)
    end
  end
end
