class CreateMajorCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :major_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
