FactoryGirl.define do
  factory :facility do
    name { Faker::Lorem.sentence(1, true, 2) }
    number { Faker::Number.number(8) }
    admin_name { Faker::Name.name }
    capacity { Faker::Number.number(2) }
    approval_date { Faker::Date.between(20.year.ago, Date.today) }
  end
end
