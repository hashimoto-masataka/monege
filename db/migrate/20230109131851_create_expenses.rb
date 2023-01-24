class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :family_id
      t.integer :price,  null:false, default: 0
      t.string :note
      t.timestamps
    end
  end
end
