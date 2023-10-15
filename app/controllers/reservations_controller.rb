class ReservationsController < ApplicationController
  def index
    @user = current_user
    @reservations = @user.reservations
  end

  def new

  end

  def confirm
    @user = current_user
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(reservation_params.require(:room_id))
    if @reservation.invalid?
      flash.now[:alert] = "予約情報が不足しています"
      render "rooms/show"
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to reservations_path
    else
      render reservations_path
    end
  end

  def show

  end

  def edit
    @reservation = Reservation.find(params[:id])
    @user = User.find_by(id: @reservation.user_id)
    @room = Room.find_by(id: @reservation.room_id)
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:notice] = "予約が完了しました"
      redirect_to reservations_path
    else
      render "reservations/edit"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約の削除が完了しました"
    redirect_to reservations_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :room_id, :start_at, :end_at, :num_people)
  end
end
