require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
  	it "should display all users" do 
  		get :index
  		assert_template :index
  		assert_template layout: "layouts/application"
		end
	end

end
