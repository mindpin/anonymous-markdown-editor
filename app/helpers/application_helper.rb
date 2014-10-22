module ApplicationHelper
  def action_css_class
    "page-#{params[:controller].sub('/', '-').gsub('_', '-')}-#{params[:action]}"
  end
end
