require 'spec_helper'

describe User do
  before (:each) do
    @attr = {:name => "John Doe", :email => "jdoe@example.com", :password => "foobar", :password_confirmation => "foobar"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a"*51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject email addresses that are invalid" do
    invalid_addresses = %w[user@foo,com user_at_foo.org example@foo. @foo.com]
    invalid_addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should accept email addresses that are valid" do
    valid_addresses = %w[user@foo.com user@foo.blech.org example.user@foo.com]
    valid_addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    user1 = User.create!(@attr)
    user1.should be_valid
    user2 = User.new(@attr)
    upperCaseEmail = @attr[:email].upcase
    user3 = User.new(@attr.merge(:email => upperCaseEmail))
  end
  
  
  describe "password vailidations" do
      it "should require a password" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
      end
      
      it "should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => "invalid")).
          should_not be_valid
      end
      
      it "should not accept short password" do
        short = "a" * 5
        hash = @attr.merge(:password => short, :password => short)
          User.new(hash).should_not be_valid
      end
    
      it "should reject long passwords" do
       long = "a" * 41
        hash = @attr.merge(:password => long, :password => long)
          User.new(hash).should_not be_valid
      end
    
  end
  
    
      describe "has_password? method" do
      
        it "should be true if the passwords match" do
         @user.has_password?(@attr[:password]).should be_true
       end
      
      it "should be false if the passwords do not match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
        it "should return nil on email/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
          wrong_password_user.should be_nil
        end
        
       it "should return nil for an email address with no user" do
          nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
          nonexistent_user.should be_nil
        end
        
        it "should return the user on email/password match" do
          matching_user = User.authenticate(@attr[:email], @attr[:password])
          matching_user.should == @user
        end
    end
  end
  
  describe "micropost associations" do
    before(:each) do
      @user = User.create!(@attr)
      @mic1 = Factory(:micropost, :user=>@user, :created_at => 1.day.ago)
      @mic2 = Factory(:micropost, :user=>@user, :created_at => 1.hour.ago)
    end
    
    it "should have microposts" do
      @user.should respond_to(:microposts)
    end
    
    it "should have microposts ordered descending by creation data" do
      @user.microposts.should == [@mic2, @mic1]
    end
  end
  
  describe "users relationship to groups" do
    before(:each) do
      fattr = {:name => "Jane Smith", :email => "jsmith@example.com"}
      @user = User.create!(fattr)
      @leader = Factory(:user)
    end
    
    it "should have groups" do
      @user.should respond_to(:groups)
    end
    
    it "should have a following? method" do
      @user.should respond_to(:following?)
    end
    
    it "should have a follow! method" do
      @user.should respond_to(:follow!)
    end
    
    it "should follow another user" do
      @user.follow!(@leader)
    end
    
    it "should unfollow a user" do
      @user.follow!(@leader)
      @user.unfollow!(@leader)
      @user.should_not be_following(@leader)
    end
  end
end