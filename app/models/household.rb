class Household < ApplicationRecord

  has_many :household_accounts, dependent: :destroy
  belongs_to :user

end
