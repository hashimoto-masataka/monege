class Expense < ApplicationRecord

  belongs_to :user
  belongs_to :category
  belongs_to :family
  has_many :household_accounts
end
