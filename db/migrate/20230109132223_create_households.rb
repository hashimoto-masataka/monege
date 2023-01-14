class CreateHouseholds < ActiveRecord::Migration[6.1]
  def change
    create_table :households do |t|
      t.integer :user_id
      t.string :prefecture
      t.string :job
      t.string :annual_income
      t.string :age
      t.string :category_name
      t.string :target_price
      t.string :category_color
      t.timestamps
    end
  end
end
