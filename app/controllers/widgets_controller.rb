class WidgetsController < ApplicationController
  before_action :set_widget, only: [:show, :edit, :update, :destroy]

  # GET /widgets
  # GET /widgets.json
  def index    
    #Display all the visible widget on the root page
    api_link = VISIBLE_WIDGETS_URL + client_id + "&client_secret=" + client_secret
    response = showoff_api_call(api_link,"get")
    @widgets = response["data"]["widgets"]
  end

  def my_widget
    #Displays logged_in users widgets
    if user_signed_in?
      authorisation = {:Authorization => 'Bearer ' + current_user.showoff_access_token}
      api_link = "https://showoff-rails-react-production.herokuapp.com/api/v1/users/" + current_user.showoff_user_id.to_s + "/widgets?client_id=" + Rails.application.credentials.config[:client_id] + "&client_secret=" + client_secret #Using User ID API
      response = showoff_api_call(api_link,"get", authorisation, nil)
    end
    @widgets = response["data"]["widgets"]
  end

  def search
    #Searching for a particular word in a widget
    if user_signed_in?
      api_link = "https://showoff-rails-react-production.herokuapp.com/api/v1/users/"+ current_user.showoff_user_id.to_s + "/widgets?client_id=" + Rails.application.credentials.config[:client_id] + "&client_secret=" + client_secret + "&term=" + params[:search].to_s #using User ID API
    else
      api_link = "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible?client_id=" + Rails.application.credentials.config[:client_id] + "&client_secret=" + client_secret + "&term=" + params[:search].to_s
    end
    response = showoff_api_call(api_link,"get", nil, nil)
    @widgets = response["data"]["widgets"]
  end

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  # GET /widgets/1/edit
  def edit
  end

  # POST /widgets
  # POST /widgets.json
  def create
    #Creating the logged_in user widget
    api_link = "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets"
    authorization = "Bearer " + current_user.showoff_access_token
    body = {
              "name": params[:widget]["name"],
              "description": params[:widget]["name"],
              "kind": params[:widget]["kind"]
            }
    
    response = showoff_api_call(api_link, "post", authorization, body)
    @widget = response["data"]["widget"]
    widget = current_user.widgets.create(body)    #entering data in table as well
    widget.update_attributes(showoff_widget_id: @widget["id"])
    
    respond_to do |format|
      if widget.present?
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
    widget = Widget.find(params[:id])
    #Updating the widget details
    if widget.present?
      authorization = "Bearer " + current_user.showoff_access_token.to_s
      api_link = "https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/" + widget.showoff_widget_id.to_s
      body =  {
                "widget": {
                            "name": params[:widget]["name"],
                            "description": params[:widget]["description"]
                          }
              }
      @widget = showoff_api_call(api_link, "put", authorization, body)
      
      respond_to do |format|
        if widget.update(widget_params)
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
