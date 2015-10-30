require_relative '../common.rb'

class User

	EMAIL_FIELD = { id: "user_email" }
	PASSWORD_FIELD = { id: "user_password" }

	SIGN_IN_LINK = { id: "sign-in" }
	SIGN_OUT_LINK = { id: "sign-out" }
	LOGIN_BUTTON = { id: "sign-in-btn" }

	def initialize(webdriver)
    @webdriver = webdriver
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

  def visit()
  	@webdriver.get $URL
  	home_page = true if Common.wait_until_found(@webdriver, SIGN_IN_LINK)
  end

end