require 'spec_helper'

describe Micropost do
  before (:each) do
     tempUser = {:name => "John Doe", :email => "jdoe@example.com"}
     @user = User.create!(tempUser)
     @attr = {:content => "some post content"}
  end
  
  it "should create a new micropost given valid attributes" do
    @user.microposts.create(@attr)
  end
  
  it "should require content" do
    no_content_micropost = @user.microposts.create(@attr.merge(:content => ""))
    no_content_micropost.should_not be_valid
  end
  
  it "should reject content that is too long" do
    long_content = "a"*151
    long_content_micropost = @user.microposts.create(@attr.merge(:content => long_content))
    long_content_micropost.should_not be_valid
  end
  
  describe "User associations" do
    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end
    
    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end
    
    it "should have the correct user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
    
  end
end