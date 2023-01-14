class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :household
  validates_uniqueness_of:household_id, scope: :user_id
  #scopeはuniquenessのオプション、１投稿に対して１人のユーザーは１いいねしかできない
end
