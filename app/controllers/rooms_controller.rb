class RoomsController < ApplicationController
  after_action :default_image, only: [:create]
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
    @user = current_user
  end

  def create
    @user = current_user
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_own_path
    else
      render "rooms/new"
    end
  end

  def show
    @user = current_user
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def own
    @user = current_user
    @rooms = @user.rooms
  end

  def edit
    @user = current_user
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to rooms_own_path
    else
      render "rooms/edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_own_path
  end

  def search
    @rooms = Room.where('address LIKE ? AND (introduction LIKE ? OR name LIKE ?)', "%#{params[:address]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
  end

  private

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :image, :address, :user_id)
  end

  def default_image
    if !@room.image.attached?
      @room.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_image.png')), filename: 'default-image.png', content_type: 'image/png')
    end
  end
end
