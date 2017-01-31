class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @categories = Category.all
    @category = Category.first
    @brands = Brand.all
  end
end
