class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # include HTTParty
  include HTTMultiParty
	base_uri Rails.application.config.api_url

  include ApplicationHelper
end
