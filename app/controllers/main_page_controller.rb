class MainPageController < ApplicationController
  def index
    @news = Company.all.sort_by(&:created_at).first(10).reverse
  end
end
