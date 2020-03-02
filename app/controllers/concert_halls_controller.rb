class ConcertHallsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :new, :edit, :update, :destroy]
  before_action :set_concert_hall, only: [:show, :edit, :update, :destroy]

  def index
    @concert_halls = ConcertHall.search_by_location_and_styles("Rio de Janeiro")
    @concert_halls = policy_scope(ConcertHall).order(created_at: :desc)
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
    params.require(:concert_hall).permit(:name, :location, :capacity, :styles, :price, :user_id)
  end

  def set_concert_hall
    @concert_hall = ConcertHall.find(params[:id])
  end
end
