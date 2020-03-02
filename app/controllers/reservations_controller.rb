class ReservationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show, :destroy]
  before_action :set_reservation, only: [:show, :destroy]

  def index
    # @concert_hall = ConcertHall.find(params[:concert_hall_id])
    @reservations = policy_scope(Reservation).order(created_at: :desc)
    @reservations = Reservation.where(user_id: params[:user_id])
  end

  def show
  end

  def new
    @reservation = Reservation.new
    @concert_hall = ConcertHall.find(params[:concert_hall_id])
    @reservation.concert_hall = @concert_hall
    authorize @reservation
  end

  def create
    @concert_hall = ConcertHall.find(params[:concert_hall_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.concert_hall = @concert_hall
    @reservation.user = current_user
    authorize @reservation

    # @reservation.user = current_user

    if @reservation.save
      redirect_to concert_hall_reservations_path(@concert_hall)
    else
      render :new
    end
  end

  def destroy
    authorize @reservation
    @reservation.destroy
    redirect_to user_reservations_path(current_user.id)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end

