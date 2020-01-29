module WidgetsHelper
  def allow_edit_destroy
    current_page?(controller: 'widgets', action: 'my_widget') ||
      request.original_url.split('/').try(:last).eql?('search?my_search=my_widget') ||
      params[:user_info].present?
  end
end
