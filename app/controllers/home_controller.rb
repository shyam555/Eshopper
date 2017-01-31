class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @categories = Category.all
    @category = nil
    @brands = Brand.all
  end
end
