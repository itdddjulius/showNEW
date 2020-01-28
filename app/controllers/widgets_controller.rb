class WidgetsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show, :index, :search]
  before_action :set_widget, only: [:show, :edit, :update, :destroy]
  include ShowoffApiService
  
  def index    
    #Display all the visible widget on the root page
    all_visible_widgets(params[:id], params[:user_info])
  end

  def my_widget
    #Displays logged_in users widgets
    code = my_widgets
    redirect_to "/" if code != 200 
  end

  def new
    @widget = Widget.new
  end

  def edit
  end

  def create
    #Creating the logged_in user widget
    response = create_widget
    if(response.is_a?(Hash) && response[:code] == 0 && response[:created_widget].present?)
      @widget = response[:api_widget]
      redirect_to my_widget_path, notice: 'Widget was successfully created.'
    else
      flash[:error] = response
      redirect_to "/widgets/new"
    end
  end

  def update
    code = update_widget
    widget = Widget.find_by_id(params[:id])
    if @widget["code"] && widget.update(widget_params)
      redirect_to my_widget_path, notice: 'Widget was successfully updated.'
    else
      redirect_to my_widget_path, flash: { error: 'Something went wrong in updating.' }
    end
  end

  def destroy
    #Destroy/Delete the widget
    widget = Widget.find_by(showoff_widget_id: params[:id])
    if current_user.showoff_user_id == widget.user.showoff_user_id
      api_link = 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/' + params[:id]
      @widget = showoff_api_call(api_link, "delete", {:Authorization => 'Bearer ' + current_user.showoff_access_token}, nil) #deleteing widget from showoff database
      widget.destroy #deleting widget from table
    end
    respond_to do |format|
      format.html { redirect_to my_widget_path, notice: 'Widget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    #Searching for a particular word in a widget
    code = search_widgets
    redirect_to "/" if code != 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find_by(showoff_widget_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def widget_params
      params.require(:widget).permit(:name, :description, :kind)
    end
end
