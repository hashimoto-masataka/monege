class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.string :family_name
      t.integer :customer_id
      t.timestamps
    end
  end
end
