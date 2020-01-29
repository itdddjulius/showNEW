# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(_resource)
    my_widget_path
  end
end
