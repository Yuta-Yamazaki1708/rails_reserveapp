class ApplicationController < ActionController::Base
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?
  after_action :default_avatar, if: :devise_controller?, only: [:create]

  
  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :avater])
  end

  def default_avatar
      if !current_user.avatar.attached?
        current_user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.png')), filename: 'default-avatar.png', content_type: 'image/png')
      end
    end
end
