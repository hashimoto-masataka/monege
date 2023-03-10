class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable

   has_many :families, dependent: :destroy
   has_many :categories, dependent: :destroy
   has_many :incomes, dependent: :destroy
   has_many :expenses, dependent: :destroy
   has_many :relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
   has_many :followings, through: :relationships, source: :followed
   has_many:followers, through: :reverse_of_relationships, source: :follower

    enum prefecture:{
     お住いの地域（未入力）:0,
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
     年齢（未入力）:0,
     １０代:1,２０代:2,３０代:3,４０代:4,５０代:5,６０代:6,７０代以上:7

   }, _prefix: true


   enum job:{
     お仕事（未入力）:0,
     無職:1,学生:2,主婦:3,会社員:4,経営者:5,その他:6

   }, _prefix: true

   enum annual_income:{
     年収（未入力）:0,
     ２００万円未満:1,２００〜４００万円未満:2,４００〜６００万円未満:3,６００〜８００万円未満:4,８００〜１０００万円未満:5,１０００〜１５００万円未満:6,
     １５００〜２０００万未満:7,２０００万円以上:8

   }, _prefix: true


   def follow(user_id)
     relationships.create(followed_id: user_id)
   end

   def unfollow(user_id)
     relationships.find_by(followed_id: user_id).destroy
   end

   def following?(user)
     followings.include?(user)
   end

   def active_for_authentication?
    super && (is_deleted == false)
   end
  
   def self.ransackable_attributes(auth_object = nil)
    #ransackable_attributesで検索対象に許可するカラムを指定
     ["age", "annual_income", "created_at", "email", "encrypted_password", "id", "is_deleted", "job", "name", "prefecture" ]
   end
   
   def self.ransackable_associations(auth_object = nill)
     []
   end 
  
  
   def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
     #find_or_create_byはデータの検索と作成を自動的に判断して処理を行う
     user.password = SecureRandom.urlsafe_base64
     user.name = "guestuser"
    end
   end
end
