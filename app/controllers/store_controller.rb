class StoreController < ApplicationController
  allow_unauthenticated_access
  include CurrentCart
  before_action :set_cart

  def index
    @counter = session[:counter]
    @products = Product.order(:title)
    @line_item = LineItem.new

    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
  end
end
