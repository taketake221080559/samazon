class User < ApplicationRecord
  has_many :reviews
  extend DisplayList

  extend SwitchFlg
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable #←confirmableを追加
  acts_as_liker

  scope :search_information, -> (keyword) { 
        where("name LIKE :keyword 
               OR id LIKE :keyword 
               OR email LIKE :keyword 
               OR address LIKE :keyword 
               OR postal_code LIKE :keyword 
               OR phone LIKE :keyword", keyword: "%#{keyword}%")
  }
  
  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    
    result = update(params, *options)
    clean_up_passwords
    result
  end
end
