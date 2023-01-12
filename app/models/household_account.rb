class HouseholdAccount < ApplicationRecord

  belongs_to :household
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end
  #すでにいいねがなされている投稿に自分のidが含まれているか判断
end
