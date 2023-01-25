class Income < ApplicationRecord
  validates :price, presence: true

  belongs_to :user
  belongs_to :family
end
