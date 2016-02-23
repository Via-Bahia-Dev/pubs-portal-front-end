module SessionsHelper

	def current_user
		User.find_by_email(session[:user_email])
	end

	def current_user_email
		session[:user_email] || ""
	end

	def current_user_token
		session[:auth_token] || ""
	end

	def signed_in?
		!session[:auth_token].nil?
	end

	def auth_headers
		{ "X-User-Email" => current_user_email, "X-Auth-Token" => current_user_token }
	end

	def store_location
		session[:return_to] = request.fullpath
	end

	def clear_stored_location
		session[:return_to] = nil
	end

end
