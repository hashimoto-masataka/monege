class Family < ApplicationRecord

  belongs_to :user
  has_many :incomes
  has_many :expenses
end
