class AddCarriageFlagToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :carriage_flag, :boolean, default: false
  end
end
