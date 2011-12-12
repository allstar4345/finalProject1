class SessionsController < ApplicationController
 def new
    @title = "Sign in"
  end

  def create
    user = User.find_by_email(params[:session][:email])
    pw = User.find_by_password(params[:session][:password])
    if (user.nil || pw.nil)?
      flash.now[:error] = "Invalid email or password."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
  end

  def destroy
     sign_out user
     redirect_to root_path
  end

end