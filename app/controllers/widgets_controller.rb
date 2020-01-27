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

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  def edit
  end

  # POST /widgets
  # POST /widgets.json
  def create
    #Creating the logged_in user widget
    response = create_widget
    @widget = response[:api_widget]
    widget = response[:widget]
    respond_to do |format|
      if @widget.present? && widget.present?
        format.html { redirect_to my_widget_path, notice: 'Widget was successfully created.' }
        format.json { render :index, status: :created, location: widget }
      else
        format.html { render :new }
        format.json { render json: widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /widgets/1
  # PATCH/PUT /widgets/1.json
  def update
    widget = Widget.find_by_id(params[:id])
    #Updating the widget details
    if widget.present?
      authorization = "Bearer " + current_user.showoff_access_token.to_s
      api_link = "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/" + widget.showoff_widget_id.to_s
      body =  {
                "widget": {
                            "name": params[:widget]["name"],
                            "description": params[:widget]["description"],
                            "kind": params[:widget]["kind"],
                          }
              }
      @widget = showoff_api_call(api_link, "put", authorization, body)
      
      respond_to do |format|
        if @widget["code"] && widget.update(widget_params)
          format.html { redirect_to my_widget_path, notice: 'Widget was successfully updated.' }
          format.json { render :index, status: :ok, location: my_widget_path }
        else
          format.html { render :edit }
          format.json { render json: widget.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /widgets/1
  # DELETE /widgets/1.json
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
