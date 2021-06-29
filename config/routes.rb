Rails.application.routes.draw do
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions',
  }

  devise_scope :admin do
    get "dashboard", :to => "dashboard#index"
    get "dashboard/login", :to => "admins/sessions#new"
    post "dashboard/login", :to => "admins/sessions#create"
    get "dashboard/logout", :to => "admins/sessions#destroy"
  end

  namespace :dashboard do
    resources :users, only: [:index, :destroy]
    resources :major_categories, except: [:new]
    resources :categories, except: [:new]
    resources :products, except: [:show] do
      collection do
        get "import/csv", :to => "products#import"
        post "import/csv", :to => "products#import_csv"
        get  "import/csv_download", :to => "products#download_csv"
      end
    end

    resources :orders, only: [:index]
  end


  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }

  devise_scope :user do
    root :to => "web#index"
    get "signup", :to => "users/registrations#new"
    get "verify", :to => "users/registrations#verify"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  resource :users, only: [:edit, :update] do
    collection do
      get "cart", :to => "shopping_carts#index"
      post "cart/create", :to => "shopping_carts#create"
      delete "cart", :to => "shopping_carts#destroy"
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      get "mypage/address/edit", :to => "users#edit_address"
      put "mypage", :to => "users#update"
      get "mypage/edit_password", :to =>"users#edit_password"
      put "mypage/password", :to => "users#update_password"
      get "mypage/favorite", :to => "users#favorite"
      delete "mypage/delete", :to => "users#destroy"
      get    "mypage/cart_history",    :to => "users#cart_history_index", :as => "mypage_cart_histories"
      get    "mypage/register_card",     :to => "users#register_card"
      post   "mypage/token",             :to => "users#token"
    end
  end

  resources :products do
    member do
      post :favorite
    end
    resources :reviews, only: [:create]
  end
end
