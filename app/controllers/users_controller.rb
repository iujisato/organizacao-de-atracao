class UsersController < ApplicationController
before_filter :authorize_user, only: [:edit, :update, :destroy]
before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.includes(:attractions)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @attractions = @user.attractions.where("time >= ?", Time.now)
                                    .order(:time)
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
      flash[:success] = 'Usuário foi criado com sucesso.'
    else
      flash[:danger] = 'Ocorreu um problema na criação do Usuário.'
      render action: "new"  
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = 'Usuário foi modificado com sucesso.'
      redirect_to root_url
    else
      flash[:danger] = 'Ocorreu um problema modificando o usuário.'
      redirect_to root_url
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
      unless @user == current_user
        redirect_to(root_url)
        flash[:danger] = 'Você não tem autorização para fazer isso.'
      end
    end
end
