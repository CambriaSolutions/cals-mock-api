# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  Facility.create!(
    name: Faker::Lorem.sentence(1, true, 2),
    number: Faker::Number.number(8),
    admin_name: Faker::Name.name,
    capacity: Faker::Number.number(2),
    approval_date: Faker::Date.between(20.year.ago, Date.today)
  )
end

p "Facilties created"
