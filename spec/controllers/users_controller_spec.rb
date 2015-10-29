require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "POST #sign_in" do
  	it "should display all users" do 
  		get :index
  		assert_template :index
  		assert_template layout: "layouts/application"
		end
	end

  describe "GET #index" do
  	it "should display all users" do 
  		get :index
  		assert_template :index
  		assert_template layout: "layouts/application"
		end
	end

end
