class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :catch_halt

  include HTTMultiParty
  base_uri Rails.application.config.api_url
  include APIHelper

  include ApplicationHelper

  def render_unauthorized
    render :file => "layouts/unauthorized", status: :unauthorized
    throw :halt
  end

  # store the current page location to return to and redirect to sign in page
  def redirect_unauthenticated
    store_location
    flash[:error] = "Please sign to access that page"
    redirect_to root_path
    throw :halt
  end

  private

  # catch halts from special renders and redirects in order to stop controller actions
  def catch_halt
    catch :halt do
      yield
    end
  end
end
