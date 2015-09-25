class AttractionsController < ApplicationController
before_filter :authorize_user, only: [:destroy]


## before_filter :filter_blank_time, only: [:create, :update]
##  def filter_blank_time
##    if params[:time]['end_time(5i)'].blank?
##       params[:time]['end_time(1i)'] = ""
##       params[:time]['end_time(2i)'] = ""
##       params[:time]['end_time(3i)'] = ""
##       params[:time]['end_time(4i)'] = ""
##       params[:time]['end_time(5i)'] = ""
##    end
##  end

  def index
    @attractions = Attraction.where("time >= ?", Time.now)
                             .order(:time)
  end

  def new
    @attraction = Attraction.new
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def create
    @attraction = current_user.attractions.build(attraction_params)
    if @attraction.save
      flash[:success] = 'Attraction was successfully created.'
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
    redirect_to root_url
  end

  private

    def authorize_user
      unless current_user
        redirect_to root_path, alert: "You need to login to continue."
      end
    end

    def attraction_params
      params.require(:attraction).permit(:name, :media, :time)
    end
end
