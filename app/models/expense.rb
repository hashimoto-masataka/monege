class Expense < ApplicationRecord
  validates :price, presence: true
  belongs_to :user
  belongs_to :category
  belongs_to :family
  has_many :household_accounts
end
