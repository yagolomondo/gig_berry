class ReservationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show, :destroy]
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
  end


  def new
    @reservation = Reservation.new
    @concert_hall = ConcertHall.find(params[:concert_hall_id])
  end

  def create
    @concert_hall = ConcertHall.find(params[:concert_hall_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.concert_hall = @concert_hall
    @reservation.user = current_user

    # @reservation.user = current_user

    if @reservation.save
      redirect_to reservation_path(@reservation)
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path
  end


  private

  def reservation_params
    params.require(:reservation).permit(:name, :location, :capacity, :styles, :price)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end

