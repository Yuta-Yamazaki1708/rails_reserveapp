class Users::ProfilesController < ActionController::Base
  layout 'application'

    def show
      @user = current_user
    end

    def edit
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update(profile_params)
        flash[:notice] = "編集が完了しました"
        redirect_to user_profile_path
      else
        flash.now[:alert] = "編集に失敗しました"
        render action: :edit
      end
    end

    private
    def profile_params
      params.require(:user).permit(:name, :introduction, :avatar)
    end
end
