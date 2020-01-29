# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  include ShowoffApiConnectorService

  # POST /resource/password
  def create
    super
    # uncomment the following code if you want to recieve a reset password email from showoff.
    # api_link = URI("https://showoff-rails-react-production.herokuapp.com/api/v1/users/reset_password")
    # body = {
    #           "user": {
    #                     "email": params[:user]["email"]
    #                   },
    #                   "client_id": client_id,
    #                   "client_secret": client_secret
    #         }

    # response = showoff_api_call(api_link,"post", nil, body)
    # response
  end

  # PUT /resource/password
  def update
    super
    api_link = URI('https://showoff-rails-react-production.herokuapp.com/api/v1/users/me/password')
    authorisation = 'Bearer ' + current_user.showoff_access_token
    body = {
      "user": {
        "current_password": params[:user][:current_password],
        "new_password": params[:user][:password]
      }
    }
    showoff_api_call(api_link, 'post', authorisation, body)
  end
end
