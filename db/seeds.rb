# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: 'test@test.com',
    password: '******',
)

User.create!(
 name:"guestuser",
 email:"guest@example.com",
 password:"hogehoge"
 )


Family.create!(
    user_id: 1,
    family_name: "太郎",

)

Category.create!(
    user_id: 1,
    category_name: "食費",
    color: '#000000',
    target_price: 100000
)



Expense.create!(
    user_id: 1,
    category_id: 1,
    family_id: 1,
    price: 100000,
    note: "レストランの代金",
)

Income.create!(
    user_id: 1,
    family_id: 1,
    price: 100000,
    note: "レストランの代金",
)