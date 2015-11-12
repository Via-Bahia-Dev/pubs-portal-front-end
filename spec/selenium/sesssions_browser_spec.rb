require 'rails_helper'
require_relative '../selenium_spec_helper.rb'

RSpec.describe "Sessions browser" do
	include Helper

  before :all do
    load_vars
    puts "Starting Sessions browser tests..."
    load_objects
    @user.sign_in($EMAIL, $PASSWORD)
  end
	
	describe "signed in user" do
    context "clicking 'Sign Out' link" do
      it "should destroy the session" do 
 				result = @user.sign_out
        expect(result).to equal(true)
		  end
    end
  end

	after :all do
    puts "Quitting Sessions browser tests..."
    @webdriver.quit()
  end

end
