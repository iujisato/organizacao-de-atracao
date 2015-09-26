class AttractionsController < ApplicationController
before_filter :authorize_user, only: [:destroy]


## before_filter :filter_blank_time, only: [:create, :update]
##  def filter_blank_time
##    if params[:time]['end_time(5i)'].blank?
##       params[:time]['end_time(4i)'] = ""
##       params[:time]['end_time(5i)'] = ""
##    end
##  end

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
      flash[:success] = 'Attraction was successfully created.'
      redirect_to user_path(@user)
    else
      flash[:danger] = 'There was a problem creating the Attraction.'
    end
  end

  def update
    @attraction = Attraction.find(params[:id])
    if @attraction.update(attraction_params)
      flash[:success] = 'Attraction was successfully updated.'
      redirect_to root_url
    else
      flash[:danger] = 'There was a problem updating the Attraction.'
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
