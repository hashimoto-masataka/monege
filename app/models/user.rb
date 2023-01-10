class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :families, dependent: :destroy
   has_many :categories, dependent: :destroy
   has_many :incomes, dependent: :destroy
   has_many :expenses, dependent: :destroy
   has_many :households, dependent: :destroy

    enum prefecture:{
     選択してください:0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
   }, _prefix: true

    enum age:{
     選択してください:0,
     １０代:1,２０代:2,３０代:3,４０代:4,５０代:5,６０代:6,７０代以上:7

   }, _prefix: true #"---"が被ると『他のenumですでに定義されています』というエラーが出るため_prexfixでエラーを回避


   enum job:{
     選択してください:0,
     無職:1,学生:2,主婦:3,会社員:4,経営者:5,その他:6

   }, _prefix: true #"---"が被ると『他のenumですでに定義されています』というエラーが出るため_prexfixでエラーを回避

   enum annual_income:{
     選択してください:0,
     ２００万円未満:1,２００〜４００万円未満:2,４００〜６００万円未満:3,６００〜８００万円未満:4,８００〜１０００万円未満:5,１０００〜１５００万円未満:6,
     １５００〜２０００万未満:7,２０００万円以上:8

   }, _prefix: true #"---"が被ると『他のenumですでに定義されています』というエラーが出るため_prexfixでエラーを回避



   def self.guest
    find_or_create_by!(nickname: 'guestcustomer' ,email: 'guest@example.com') do |customer|
     customer.password = SecureRandom.urlsafe_base64
     customer.nickname = "guestcustomer"
    end
   end
end
