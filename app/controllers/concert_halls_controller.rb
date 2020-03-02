class ConcertHallsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :new, :edit, :update, :destroy]
  before_action :set_concert_hall, only: [:show, :edit, :update, :destroy]

  def index
    @concert_halls = ConcertHall.geocoded #returns concert_halls with coordinates
    @markers = @concert_halls.map do |concert_hall|
      {
        lat: concert_hall.latitude,
        lng: concert_hall.longitude
      }
    end
    @concert_halls = policy_scope(ConcertHall).order(created_at: :desc)
    if params[:location] != nil
      if params[:location] == ""
        @concert_halls = ConcertHall.all
      else
        @concert_halls = ConcertHall.search_by_location_and_styles(params[:location])
      end
    end

    # <-- Code um nach Location UND Style zu filtern: -->

    # if params[:location] == "" && params[:styles] == ""
    #   @concert_halls = ConcertHall.all
    # elsif params[:location] == "" && params[:styles] != ""
    #   @concert_halls = ConcertHall.search_by_location_and_styles(params[:styles])
    # elsif params[:styles] == "" && params[:location] != ""
    #   @concert_halls = ConcertHall.search_by_location_and_styles(params[:location])
    # else
    #   @concert_halls_location = ConcertHall.search_by_location_and_styles(params[:location])
    #   @concert_halls = []
    #   @concert_halls_location.each do |concert_hall|
    #     @concert_halls << concert_hall if concert_hall.styles == params[:styles]
    #   end
    # end
  end

  def display
    @concert_halls = ConcertHall.where(user_id: params[:user_id])
  end

  def show
  end

  def new
    @concert_hall = ConcertHall.new
    authorize @concert_hall
  end

  def create
    @concert_hall = ConcertHall.new(concert_hall_params)
    authorize @concert_hall
    @concert_hall.user = current_user
    if @concert_hall.save
      redirect_to concert_hall_path(@concert_hall)
    else
      render :new
    end
  end

  def edit
    authorize @concert_hall
  end

  def update
    authorize @concert_hall
    if @concert_hall.update(concert_hall_params)
      redirect_to concert_hall_path(@concert_hall)
    else
      render :edit
    end
  end

  def destroy
    authorize @concert_hall
    @concert_hall.destroy
    redirect_to concert_halls_path
  end

  private

  def concert_hall_params
    params.require(:concert_hall).permit(:name, :location, :capacity, :styles, :price, :user_id, :body, photos: [])
  end

  def set_concert_hall
    @concert_hall = ConcertHall.find(params[:id])
  end
end
