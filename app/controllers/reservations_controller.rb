class ReservationsController < ApplicationController
  def index
    @user = current_user
    @reservations = @user.reservations
  end

  def new

  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    if @reservation.invalid?
      render new_reservation_path
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservations_path
    else
      render new_reservation_path
    end
  end

  def show
   
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to reservations_path
    else
      render "edit"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :room_id, :start_at, :end_at, :num_people)
  end
end
