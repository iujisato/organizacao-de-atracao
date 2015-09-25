class LoginController < ApplicationController
  def new
  end
  
  def destroy
    session.clear
    redirect_to root_path
  end

  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid e-mail or password."
      render action: "new"
    end
  end
end