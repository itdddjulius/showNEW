class UsersController < ApplicationController
  include ShowoffApiService

  # show the user object along with the visible widgets of the user.
  def show
    visible_widgets
  end
end
