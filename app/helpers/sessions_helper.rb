module SessionsHelper

	def current_user
		User.find_by_email(session[:user_email])
	end
	def signed_in?
		current_user
	end
end
