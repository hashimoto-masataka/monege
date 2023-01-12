class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :household_account
  validates_uniqueness_of:household_account_id, scope: :user_id
  #scopeはuniquenessのオプション、１投稿に対して１人のユーザーは１いいねしかできない
end
