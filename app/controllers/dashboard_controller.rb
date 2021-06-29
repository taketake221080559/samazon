class DashboardController < ApplicationController
    before_action :authenticate_admin!, expect: :index

    layout 'dashboard/dashboard'

    def index
    @page != nil ? @page
                 : 1
     @sort = params[:sort]
     @billings = if params[:sort] == "month"
                   ShoppingCart.get_monthly_billings
                 else
                   ShoppingCart.get_daily_billings
                 end
 
     @total = ShoppingCart.bought_cart_ids.count
     @sort_list = ShoppingCart.sort_list

    end
end
