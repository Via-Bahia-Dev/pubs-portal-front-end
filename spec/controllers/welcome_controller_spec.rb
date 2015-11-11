require 'rails_helper'
require_relative '../selenium_spec_helper.rb'

RSpec.describe WelcomeController, type: :controller do
  include Helper

  before :all do
    load_vars
    puts "Starting Welcome Controller tests..."
    load_objects
  end

  describe "GET /" do
    context "when not signed in" do
  	  
      it "should display index page with sign in link" do 
        result = @user.visit(false)
        expect(result).to equal(true)
		  end
    end
    context "when signed in" do
      
      it "should diplay menu bar with sign out option" do
      result = @user.sign_in($EMAIL, $PASSWORD)
      expect(result).to equal(true)
      end

    end
  end

  after :all do
    puts "Quitting Welcome Controller tests..."
    @webdriver.quit()
  end

end
