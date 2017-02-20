class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @categories = Category.all
    @category = Category.first
    @brands = Brand.all
  end
  
  def routing_error
    render partial: "errors/error_404"
  end
  
end
