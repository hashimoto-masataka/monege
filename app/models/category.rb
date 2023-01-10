class Category < ApplicationRecord

  belongs_to :user
  has_many :expenses
  has_many :household_accounts
end
