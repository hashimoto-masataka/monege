class Expense < ApplicationRecord
  validates :price, presence: true
  validates :note,
    length: { minimum: 0, maximum: 25 }
  
  belongs_to :user
  belongs_to :category
  belongs_to :family
  
  
 
end
