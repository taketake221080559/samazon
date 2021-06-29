class Dashboard::OrdersController < ApplicationController
    before_action :authenticate_admin!
    layout "dashboard/dashboard"
  
    def index
      @code = params[:code].present? ? params[:code] : ""
                                    
      @orders = []
      @orders_array = []
      if @code.present?
          @orders = ShoppingCart.get_orders({code: @code})
          @orders_array = Kaminari.paginate_array(@orders.to_a).page(params[:page]).per(15)
      else
          @orders_array = ShoppingCart.all.page(params[:page]).per(15)
      end
      @total = @orders_array.count
    end
  end