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
        result = @user.visit
        expect(result).to equal(true)
		  end

      it "should log in (will move later)" do
      result = @user.sign_in($EMAIL, $PASSWORD)
      expect(result).to equal(true)
      end

	  end
  end

  after :all do
    puts "Quitting Selenium tests..."
    @webdriver.quit()
  end

end
