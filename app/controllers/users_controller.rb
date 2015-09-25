class UsersController < ApplicationController
before_filter :authorize_user, only: [:edit, :update, :destroy]
before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
      flash[:success] = 'User was successfully created.'
    else
      flash[:danger] = 'There was a problem creating the User.'
      render action: "new"  
    end
  end

  def update
    @user = current_user.users.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'User was successfully updated.'
      redirect_to root_url
    else
      flash[:danger] = 'There was a problem updating the User.'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
      flash[:danger] = "You are not authorized to do this."
    end
end
