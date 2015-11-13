require 'rails_helper'
require_relative '../selenium_spec_helper.rb'

RSpec.describe "Users browser" do
	include Helper

  before :all do
  	# user = User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
    load_vars
    puts "Starting Users browser tests..."
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
    context "should display an 'Add User' link on the users list page if user has ability" do
      it "that goes to the add user page" do
        @user.users_list
        result = @user.add_user
        expect(result).to equal(true)
      end
      it "should successfully create a new user" do
        @user.create_user
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
    puts "Quitting Users browser tests..."
    @webdriver.quit()
  end

end
