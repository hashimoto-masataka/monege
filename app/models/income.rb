class Income < ApplicationRecord

  belongs_to :user
  belongs_to :family
  has_many :household_accounts
end
