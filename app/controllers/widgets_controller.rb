class WidgetsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: %i[show index search]
  before_action :set_widget, only: [:edit]
  include ShowoffApiService

  def index
    # Display all the visible widget on the root page. Defined in ShowoffApiService
    all_visible_widgets
  end

  def my_widget
    # Displays logged_in users widgets. Defined in ShowoffApiService
    my_widgets
  end

  def new
    @widget = Widget.new
  end

  def edit; end

  def create
    # Creating the logged_in user widget. Defined in ShowoffApiService
    create_widget
  end

  def update
    update_widget
  end

  def destroy
    # Destroy/Delete the widget
    destroy_widget
  end

  def search
    # Searching for a particular word in a widget
    search_widgets
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_widget
    @widget = Widget.find_by(showoff_widget_id: params[:id])
  end
end
