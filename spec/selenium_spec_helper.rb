require 'selenium-webdriver'
require_relative './lib/user.rb'

module Helper

	def load_vars()
		$EMAIL = "test1@test.com"
		$PASSWORD = "asdfasdf"

		$URL = "http://localhost:3000"
	end	

	def load_objects()
  	# @webdriver = Selenium::WebDriver.for :firefox, :profile => 'default'

  	# If true, make webdriver object pointed to Sauce Labs cloud. 
  	# If false, use local webdriver.
  	if ENV['USE_SAUCE_LABS']
  		caps = Selenium::WebDriver::Remote::Capabilities.chrome
			caps['platform'] = 'Windows 10'
			caps['version'] = '31.0'
 
  		sauce_endpoint = "http://davidwosk1:0760394d-b006-4432-a9da-fabc6854f154@ondemand.saucelabs.com:80/wd/hub"
  		@webdriver = Selenium::WebDriver.for :remote, :url => sauce_endpoint, :desired_capabilities => caps
  	elsif ENV['TRAVIS']
      @webdriver = Selenium::WebDriver.for :phantomjs
    else
  		@webdriver = Selenium::WebDriver.for :firefox, :profile => 'default'
    end
 
    @user = User1.new(@webdriver)
    @user.visit(false)
	end

end