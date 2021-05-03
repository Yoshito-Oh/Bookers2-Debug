class ApplicationController < ActionController::Base
  before_action :authenticate_user! ,except: [:top, :about]
  #6. except: [:top, :about]を追記、top, about以外はログインユーザーしか開けないと指定
	before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
    #10. 「root_path」を「user_path(current_user.id)」に変更。ログインしたら現在のユーザー画面へ
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
