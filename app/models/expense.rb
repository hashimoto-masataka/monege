class Expense < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :note,
    length: { minimum: 0, maximum: 25 }
  
  belongs_to :user
  belongs_to :category
  belongs_to :family
  
  
 
end
