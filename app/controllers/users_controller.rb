class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create #not used
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update #not used
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy #not used
  end

  private

  def set_user
    # if current_user.present?
    #   #fetch current user details from showoff user API.
    #   user_response = showoff_api_call(MY_USER_URL, "get", authorization_bearer(current_user))
    #   @user = user_response["data"]["user"]
    #   my_widgets_url = MY_WIDGETS_URL + "?client_id=" + client_id + "&client_secret=" + client_secret
    #   widget_response = showoff_api_call(my_widgets_url, "get", authorization_bearer(current_user))
    #   @widgets = widget_response["data"]["widgets"]
    # end

    user_widgets_url = USER_WIDGETS + "#{params[:id]}/widgets/?client_id=#{client_id}&client_secret=#{client_secret}"
    response = showoff_api_call(user_widgets_url, "get", {})
    @user = response["data"]["widgets"].first["user"]
    @widgets = response["data"]["widgets"]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :image_url, :client_id, :client_sceret, :date_of_birth)
  end
end
