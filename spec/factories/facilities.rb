FactoryGirl.define do
  factory :facility do
    # required  fields
    isn_lis_fac_file      { Faker::Number.number(2) }
    fac_nbr               { Faker::Number.number(2) }
    fac_region_do         { Faker::Number.number(2) }
    fac_region_co         { Faker::Number.number(2) }

    # non-required fields
    fac_name              { Faker::Lorem.sentence(1, true, 2) }
    fac_licensee_name     { Faker::Name.name }
    fac_capacity          { Faker::Number.number(2) }
    fac_last_visit_date   { Faker::Date.between(1.year.ago, Date.today,) }
    fac_lic_expir_date    { Faker::Date.between(Date.today, 1.year.from_now) }
    fac_res_street_addr   { Faker::Address.street_address }
    fac_res_city          { Faker::Address.city }
    fac_res_state         { Faker::Address.state_abbr }
    fac_res_zip_code      { Faker::Number.number(5) }
  end
end
