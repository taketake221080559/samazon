class AddRecommendedFlagToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :recommended_flag, :boolean, default: false
  end
end
