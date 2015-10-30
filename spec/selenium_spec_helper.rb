require 'selenium-webdriver'
require_relative './lib/user.rb'

module Helper

	def load_vars()
		$EMAIL = "test1@test.com"
		$PASSWORD = "asdfasdf"

		$URL = "http://localhost:3000"
	end	

	def load_objects()
  	# @webdriver = Selenium::WebDriver.for :firefox
  	caps = Selenium::WebDriver::Remote::Capabilities.chrome
		caps['platform'] = 'Windows 10'
		caps['version'] = '31.0'
 
  	sauce_endpoint = "http://davidwosk1:0760394d-b006-4432-a9da-fabc6854f154@ondemand.saucelabs.com:80/wd/hub"
  	@webdriver = Selenium::WebDriver.for :remote, :url => sauce_endpoint, :desired_capabilities => caps
    @user = User.new(@webdriver)
	end

end