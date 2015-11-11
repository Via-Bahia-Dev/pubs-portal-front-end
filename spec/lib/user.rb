require_relative '../common.rb'

class User1

	EMAIL_FIELD = { id: "user_email" }
	PASSWORD_FIELD = { id: "user_password" }

	SIGN_OUT_LINK = { id: "sign-out" }
	SIGN_IN_BUTTON = { id: "sign-in-btn" }

	EDIT_PROFILE_LINK = { id: "edit-profile" }
	HOME_LINK = { id: "home" }
	USER_EMAIL = { id: "user_email" }
	USER_FIRST_NAME = { id: "user_first_name" }
	USER_LAST_NAME = { id: "user_last_name" }
	USERS_LIST_LINK = { id: "users-list" }
	USERS_TABLE = { id: "users-table" }
	VIEW_PROFILE_LINK = { id: "view-profile" }
	WELCOME_HEADER = { id: "welcome-header" }

	def initialize(webdriver)
    @webdriver = webdriver
  end

  def edit_profile()
  	Common.click(@webdriver, EDIT_PROFILE_LINK)
  	Common.send_text(@webdriver, USER_FIRST_NAME, "NewFirstName")
  	Common.send_text(@webdriver, USER_LAST_NAME, "NewLastName")
  	Common.send_text(@webdriver, USER_EMAIL, "newemail@test.com")

  	
  end

  def home()
  	# Common.find(@webdriver, HOME_LINK)
  	Common.click(@webdriver, HOME_LINK)

  	home_page = true if Common.find(@webdriver, WELCOME_HEADER)
  end

  def sign_in(email, password)
		puts "User #{email} logging in"
   
    Common.find(@webdriver, SIGN_IN_BUTTON)
    Common.send_text(@webdriver, EMAIL_FIELD, email)
    Common.send_text(@webdriver, PASSWORD_FIELD, password)
    Common.click(@webdriver, SIGN_IN_BUTTON)

    logged_in = true if Common.find(@webdriver, SIGN_OUT_LINK)
  
  end

  def sign_out
  	# Common.find(@webdriver, SIGN_OUT_LINK)
  	Common.click(@webdriver, SIGN_OUT_LINK)

  	signed_out = true if Common.find(@webdriver, SIGN_IN_BUTTON)
  end

  # Assumes user is logged in unless method is called with false argument.
  def visit(logged_in=true)
  	@webdriver.get $URL
  	if logged_in
  		home_page = true if Common.find(@webdriver, WELCOME_HEADER)
   	else
   		home_page = true if Common.find(@webdriver, SIGN_IN_BUTTON)
   	end
  end

  def view_profile()
  	# Common.find(@webdriver, VIEW_PROFILE_LINK)
  	Common.click(@webdriver, VIEW_PROFILE_LINK)

  	profile_page = true if Common.find(@webdriver, EDIT_PROFILE_LINK)
  end

  def users_list()
  	# Common.find(@webdriver, USERS_LIST_LINK)
  	Common.click(@webdriver, USERS_LIST_LINK)

  	users_list = true if Common.find(@webdriver, USERS_TABLE)
  end

end