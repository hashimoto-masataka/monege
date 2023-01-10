class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.integer :user_id
      t.string :category_name
      t.string :color
      t.integer :target_price
      t.timestamps
    end
  end
end
