require 'selenium-webdriver'
require_relative './lib/user.rb'

module Helper

	def load_vars()
		$USERNAME = "test1@test.com"
		$PASSWORD = "asdfasdf"

		$URL = "http://localhost:3000"
	end	

	def load_objects()
  	@webdriver = Selenium::WebDriver.for :firefox, :profile => 'default'
    @user = User.new(@webdriver)
	end

end