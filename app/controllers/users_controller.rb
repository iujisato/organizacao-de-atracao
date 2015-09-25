class UsersController < ApplicationController


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
    @user = User.find(params[:id])
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
end
