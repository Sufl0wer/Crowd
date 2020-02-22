class WebSiteController < ApplicationController
  def index
    @news_record = Company.all.sort_by(&:created_at).first(10).reverse
  end

  def search
    @search_results = Company.search(params[:search])
    render 'web_site/search'
  end

  def switch_theme
    session[:theme] =
    if session[:theme]
      nil
    else
      'dark'
    end
    redirect_back fallback_location: root_path
  end
end
