class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show]
  include ShowoffApiService

  #show the user object along with the visible widgets of the user.
  def show
    code = visible_widgets(params[:id], params[:user_info])
    # redirect_to "/" if code != 200 
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :image_url, :client_id, :client_sceret, :date_of_birth)
  end
end
