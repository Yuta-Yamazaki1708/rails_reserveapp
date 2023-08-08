class Users::ProfilesController < ActionController::Base
  layout 'application'

    def show
      current_user
    end

    def edit
      current_user
    end

    def update
    current_user
      if current_user.update(profile_params)
        flash[:success] = "編集が完了しました"
        redirect_to user_profile_path
      else
        flash[:failure] = "編集に失敗しました"
        render user_profile_edit_path
      end
    end

    private
    def profile_params
      params.require(:user).permit(:name, :introduction, :avatar)
    end
end
