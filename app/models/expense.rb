class Expense < ApplicationRecord

  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :family, optional: true
  has_many :household_accounts
end
