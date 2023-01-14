class HouseholdAccount < ApplicationRecord

  belongs_to :household


  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end
  #すでにいいねがなされている投稿に自分のidが含まれているか判断
end
