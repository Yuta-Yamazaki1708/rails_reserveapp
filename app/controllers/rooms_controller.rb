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
      flash[:notice] = "登録に成功しました"
      redirect_to rooms_own_path
    else
      flash[:alert] = "登録に失敗しました"
      flash[:error] = @room.errors.full_messages
      redirect_to new_room_path
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
    @user = current_user
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "編集に成功しました"
      redirect_to rooms_own_path
    else
      flash[:error] = @room.errors.full_messages
      flash[:alert] = "編集に失敗しました"
      redirect_to edit_room_path(@room)
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設情報の削除が完了しました"
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
