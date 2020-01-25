# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource. This method will create using showoff API.
  def create
    body = {
          "client_id": client_id,
          "client_secret": client_secret,
          "user": {
            "first_name": params[:user][:first_name],
            "last_name": params[:user][:last_name],
            "password": params[:user][:password],
            "email": params[:user][:email],
            "image_url": params[:user][:image_url]
          }
        }
    response = showoff_api_call(USERS_URL, "post", body)
    return response["message"] if response["code"] != 0 
    #override the device registrations method to store showoff token in user object.
    build_resource(sign_up_params.to_h.merge!({:showoff_user_id => response["data"]["user"]["id"], :showoff_access_token => response["data"]["token"]["access_token"], :showoff_refresh_token => response["data"]["token"]["refresh_token"]}))
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        respond_with resource, :location => after_sign_up_path_for(resource)
      end
    else
      clean_up_passwords
      respond_with resource
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params    
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,:image_url, :showoff_user_id, :showoff_access_token, :showoff_refresh_token)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    my_widget_path
  end

end
