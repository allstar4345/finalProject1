require 'spec_helper'

  describe UsersController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @user = User.create!(:name => "John Doe", :email => "jdoe@example.com")
    end
    
    it "it should be successful" do
      get :show, :id => @user.id
      response.should be_success
    end

    it "should have the right title" do
      get 'show', :id => @user.id
      response.should have_selector("title", :content => @user.name)
    end
  end

  describe "POST 'create'" do
    describe "success" do

      before(:each) do
        @attr = {:name => "John Doe", :email => "jdoe@example.com"}
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

    end
  end
  
  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end

    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "Current users")
    end
  end

end