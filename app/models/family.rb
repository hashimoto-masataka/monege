class Family < ApplicationRecord

  belongs_to :user
  #registraitionコントローラにサインアップ時にuser.nameをfamily_nameに登録するように設定
  has_many :incomes
  has_many :expenses
end
