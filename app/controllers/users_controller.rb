class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  
  def edit
    
  end

  def update
    
    @user.update_without_password(user_params)
    redirect_to mypage_users_url
  end

  def mypage
   
  end
  
  def edit_address
    
  end
  
  def update_password
    if password_set?
      @user.update_password(user_params)
      flash[:notice] = "パスワードは正しく更新されました。"
      redirect_to root_url
    else
      @user.errors.add(:password, "パスワードに不備があります。")
      render "edit_password"
    end
  end
  
  def edit_password
  end
  
  def favorite
    @favorites = @user.likees(Product)
  end

  def destroy
    @user.deleted_flg = User.switch_flg(@user.deleted_flg)
    @user.update(deleted_flg: @user.deleted_flg)
    redirect_to mypage_users_url
  end

  def cart_history_index
    @orders = ShoppingCart.get_current_user_orders(@user)
    @orders_array = Kaminari.paginate_array(@orders.to_a).page(params[:page]).per(15)
    @total = @orders.count
  end

  def register_card
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    @count = 0
    card_info = {}

    if @user.token != ""
      result = Payjp::Customer.retrieve(@user.token).cards.all(limit: 1).data[0]
      @count = Payjp::Customer.retrieve(@user.token).cards.all.count

      card_info[:brand] = result.brand
      card_info[:exp_month] = result.exp_month
      card_info[:exp_year] = result.exp_year
      card_info[:last4] = result.last4
    end

    @card = card_info
  end

  def token
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = @user.token

    if @user.token != ""
      cu = Payjp::Customer.retrieve(customer)
      delete_card = cu.cards.retrieve(cu.cards.data[0]["id"])
      delete_card.delete
      cu.cards.create(:card => params["payjp-token"])
    else
      cu = Payjp::Customer.create
      cu.cards.create(:card => params["payjp-token"])
      @user.token = cu.id
      @user.save
    end
    redirect_to mypage_users_url
  end

      
  
  private
  
    def set_user
      @user = current_user
    end
    
    def user_params
      params.permit(:name, :email, :address, :phone, :password, :password_confirmation)
    end
    
    def password_set?
      user_params[:password].present? && user_params[:password_confirmation].present? ?
      true : false
    end
end
