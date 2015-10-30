require_relative '../common.rb'

class User

	EMAIL_FIELD = { id: "user_email" }
	PASSWORD_FIELD = { id: "user_password" }

	SIGN_IN_LINK = { id: "sign-in" }
	SIGN_OUT_LINK = { id: "sign-out" }
	LOGIN_BUTTON = { id: "sign-in-btn" }

	EDIT_PROFILE_LINK = { id: "edit-profile" }
	HOME_LINK = { id: "home" }
	USERS_LIST_LINK = { id: "users-list" }
	USERS_TABLE = { id: "users-table" }
	VIEW_PROFILE_LINK = { id: "view-profile" }
	WELCOME_HEADER = { id: "welcome-header" }

	def initialize(webdriver)
    @webdriver = webdriver
  end

  def home()
  	Common.wait_until_found(@webdriver, HOME_LINK)
  	Common.find_n_click(@webdriver, HOME_LINK)

  	home_page = true if Common.wait_until_found(@webdriver, WELCOME_HEADER)
  end

  def sign_in(email, password)
		puts "User #{email} logging in"
   
   	Common.find_n_click(@webdriver, SIGN_IN_LINK)
    Common.wait_until_found(@webdriver, LOGIN_BUTTON)
    Common.send_text(@webdriver, EMAIL_FIELD, email)
    Common.send_text(@webdriver, PASSWORD_FIELD, password)
    Common.find_n_click(@webdriver, LOGIN_BUTTON)

    logged_in = true if Common.wait_until_found(@webdriver, SIGN_OUT_LINK)
  
  end

  def sign_out
  	Common.wait_until_found(@webdriver, SIGN_OUT_LINK)
  	Common.find_n_click(@webdriver, SIGN_OUT_LINK)

  	signed_out = true if Common.wait_until_found(@webdriver, SIGN_IN_LINK)
  end

  # Assumes user is logged in unless method is called with false argument.
  def visit(logged_in=true)
  	@webdriver.get $URL
  	if logged_in
  		home_page = true if Common.wait_until_found(@webdriver, WELCOME_HEADER)
   	else
   		home_page = true if Common.wait_until_found(@webdriver, SIGN_IN_LINK)
   	end
  end

  def view_profile()
  	Common.wait_until_found(@webdriver, VIEW_PROFILE_LINK)
  	Common.find_n_click(@webdriver, VIEW_PROFILE_LINK)

  	profile_page = true if Common.wait_until_found(@webdriver, EDIT_PROFILE_LINK)
  end

  def users_list()
  	Common.wait_until_found(@webdriver, USERS_LIST_LINK)
  	Common.find_n_click(@webdriver, USERS_LIST_LINK)

  	users_list = true if Common.wait_until_found(@webdriver, USERS_TABLE)
  end

end