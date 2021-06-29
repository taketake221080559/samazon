class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews
  acts_as_likeable
  has_one_attached :image
  


#  scope :display_list, -> (category, page) { 
#   if category != "none"
#      where(category_id: category).page(page).per(PER)
#   else
#      page(page).per(PER)
#   end
#  }

 extend DisplayList
#  scope :category_products, -> (category, page) { 
#   where(category_id: category).page(page).per(PER)
#  }
#  scope :sort_products, -> (sort_order, page) {
#   where(category_id: sort_order[:sort_category]).order(sort_order[:sort]).
#   page(page).per(PER)
#  }

 scope :on_category, -> (category) { where(category_id: category) }
 scope :sort_order, -> (order) { order(order) }

 scope :category_products, -> (category, page) { 
   on_category(category).
   display_list(page)
  }

 scope :sort_products, -> (sort_order, page) {
   on_category(sort_order[:sort_category]).
   sort_order(sort_order[:sort]).
   display_list(page)
   }
   
scope :sort_list, -> { 
    {
      "並び替え" => "", 
      "価格の安い順" => "price asc",
      "価格の高い順" => "price desc", 
      "出品の古い順" => "updated_at asc", 
      "出品の新しい順" => "updated_at desc"
    }
  }
  
  scope :in_cart_product_names, -> (cart_item_ids) { where(id: cart_item_ids).pluck(:name) }
  scope :recently_products, -> (number) { order(created_at: "desc").take(number) }
  scope :recommend_products, -> (number) { where(recommended_flag: true).take(number) }
  scope :check_products_carriage_list, -> (product_ids) { where(id: product_ids).pluck(:carriage_flag)}

  def self.import_csv(file)
    new_products = []
    update_products = []
    CSV.foreach(file.path, headers: true, encoding: "Shift_JIS:UTF-8") do |row|
      row_to_hash = row.to_hash
      byebug
      if row_to_hash[:id].present?
        update_product = find(id: row_to_hash[:id])
        update_product.attributes = row.to_hash.slice!(csv_attributes)
        update_products << update_product
      else
        new_product = new
        new_product.attributes = row.to_hash.slice!(csv_attributes)
        new_products << new_product
      end
    end
    if update_products.present?
      import update_products, on_duplicate_key_update: csv_attributes
    elsif new_products.present?
      import new_products
    end
  end

  
  def reviews_new
    reviews.new
  end

  def reviews_with_id
    reviews.reviews_with_id
  end

  private
   def self.csv_attributes
    [:name, :description, :price, :recommended_flag, :carriage_flag ]
   end

end
