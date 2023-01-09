class CreateHouseholdAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :household_accounts do |t|
      t.integer :household_id
      t.string :category_name
      t.string :color
      t.integer :target_price
      t.timestamps
    end
  end
end
