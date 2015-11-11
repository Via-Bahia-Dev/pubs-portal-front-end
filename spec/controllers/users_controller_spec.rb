require 'rails_helper'
require_relative '../selenium_spec_helper.rb'

RSpec.describe UsersController, type: :controller do
	include Helper

  before :all do
  	# user = User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
    load_vars
    puts "Starting Users Controller tests..."
    load_objects
    @user.sign_in($EMAIL, $PASSWORD)
  end

  let(:valid_attributes) {
    { email: "test1@test.com", password: "asdfasdf",  first_name: "Test", last_name: "Name" }
  }
	
	describe "Menu bar" do
    context "should display 'Home' link" do
      it "that takes user to home page" do 
 				result = @user.home
        expect(result).to equal(true)
		  end
    end
    context "should display 'Users List' link" do
      it "that takes user to users list page" do 
 				result = @user.users_list
        expect(result).to equal(true)
		  end
    end
    context "should display 'View Profile' link" do
      it "that takes user to profile page" do 
 				result = @user.view_profile
        expect(result).to equal(true)
		  end

		  it "where user can succesfully edit profile and is redirected to home page" do
		  	@user.view_profile
		  	@user.edit_profile
			end
    end
  end

  after :each do
  	@user.visit
  end

	after :all do
    puts "Quitting Users Controller tests..."
    @webdriver.quit()
  end

end
