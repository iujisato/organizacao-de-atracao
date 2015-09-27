class AttractionsController < ApplicationController
before_filter :authorize_user, only: [:destroy]

  def index
    @user = User.find(params[:user_id])
    @attractions = Attraction.where("time >= ?", Time.now)
                             .order(:time)
  end

  def new
    @user = User.find(params[:user_id])
    @attraction = @user.attractions.build
  end

  def edit
    @user = User.find(params[:user_id])
    @attraction = Attraction.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @attraction = @user.attractions.build(attraction_params)
    if @attraction.save
      flash[:success] = 'Atração foi criada com sucesso.'
      redirect_to user_path(@user)
    else
      flash[:danger] = 'Houve um problema na criação da Atração.'
    end
  end

  def update
    user = User.find(params[:user_id])
    @attraction = Attraction.find(params[:id])
    if @attraction.update(attraction_params)
      flash[:success] = 'Atração foi modificada com sucesso.'
      redirect_to user_path(user)
    else
      flash[:danger] = 'Houve um problema modificando a Atração.'
    end
  end

  def destroy
    @attraction = current_user.attractions.find(params[:id])
    @attraction.destroy
    redirect_to user_path(current_user)  
  end

private

    def attraction_params
      params.require(:attraction).permit(:name, :media, :time)
    end
end
