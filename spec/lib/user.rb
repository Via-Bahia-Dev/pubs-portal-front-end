class User

	def initialize(webdriver)
    @webdriver = webdriver
  end

  def sign_in(username, password)
  end

  def visit()
  	@webdriver.get $URL
  end

end