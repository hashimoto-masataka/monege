class Category < ApplicationRecord
  validates :category_name,
    length: { minimum: 0, maximum: 10 }

  belongs_to :user
  has_many :expenses
  has_many :household_accounts
end
