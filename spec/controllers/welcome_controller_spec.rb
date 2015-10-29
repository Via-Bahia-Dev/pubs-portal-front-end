require 'rails_helper'
require_relative '../selenium_spec_helper.rb'

RSpec.describe WelcomeController, type: :controller do
  include Helper

  before :all do
    load_vars
    puts "Starting Selenium tests..."
    load_objects
  end

  describe "GET #index" do
    context "when not logged in" do
  	  
      it "should display index page with sign in link" do 
        puts "testing"
        @user.visit
        @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
    
        begin
          @wait.until { @webdriver.find_element(id: 'sign-in') }
          found_elem = @webdriver.find_element(id: 'sign-in')
    
        rescue Selenium::WebDriver::Error::TimeOutError
          puts "SELENIUM: Timeout - sign-in"
          return nil
        rescue Selenium::WebDriver::Error::NoSuchElementError
          puts "SELENIUM: NoElement - sign-in"
          return nil
        rescue Selenium::WebDriver::Error::InvalidSelectorError
          puts 'SELENIUM: Invalid Selector Error - sign-in'
          return nil
        end

		  end

	  end
  end

  after :all do
    puts "Quitting Selenium tests..."
    @webdriver.quit()
  end

end
