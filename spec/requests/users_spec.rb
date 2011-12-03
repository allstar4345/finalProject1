require 'spec_helper'

describe "Users" do
  describe "GET /users" do
     it "should have an index page at '/users'" do
      get users_path
      response.status.should be(200)
      response.should be_success
      response.should have_selector("title", :content => "Current users")
    end
    
    it "should have the right links on the layout" do
      visit users_path
      click_link "Home"
      response.should have_selector('title', :content => "Home")
    end
  end
end