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
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path
    else
      render new_room_path
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def own
    @user = current_user
    @rooms = @user.rooms
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to rooms_own_path
    else
      render edit_room_path(@room)
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_own_path
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
