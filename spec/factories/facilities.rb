FactoryGirl.define do
  factory :facility do
    # required  field
    fac_nbr { Faker::Number.number(2) }

    # non-required fields
    fac_name { Faker::Lorem.sentence(1, true, 2) }
    fac_licensee_name { Faker::Name.name }
    fac_orig_appl_rec_date { Faker::Date.between(1.year.ago, Date.today,) }
    fac_lic_eff_date { Faker::Date.between(Date.today, 1.year.from_now) }
    fac_res_street_addr { Faker::Address.street_address }
    fac_res_city { Faker::Address.city }
    fac_res_state { Faker::Address.state_abbr }
    fac_res_zip_code { Faker::Number.number(5) }

    # associations
    county_mapping
    district_office_mapping
    status_mapping
    type_mapping
    last_visit_reason_mapping
    assigned_worker_mapping
  end

  factory :county_mapping, class: 'CodeMapping::County' do
    key { Faker::Lorem.characters(2) }
    code { Faker::Number.number(4) }
    value { Faker::Address.city }
    type { 'CodeMapping::County' }
  end

  factory :district_office_mapping, class: 'CodeMapping::DistrictOffice' do
    key { Faker::Lorem.characters(2) }
    code { Faker::Number.number(4) }
    value { Faker::Address.city }
    type { 'CodeMapping::DistrictOffice' }
  end

  factory :status_mapping, class: 'CodeMapping::FacilityStatus' do
    key { Faker::Lorem.characters(2) }
    code { Faker::Number.number(3) }
    value { Faker::Address.city }
    type { 'CodeMapping::FacilityStatus' }
  end

  factory :type_mapping, class: 'CodeMapping::FacilityType' do
    key { Faker::Lorem.characters(2) }
    code { Faker::Number.number(3) }
    value { Faker::Address.city }
    type { 'CodeMapping::FacilityType' }
  end

  factory :last_visit_reason_mapping, class: 'CodeMapping::LastVisitReason' do
    key { Faker::Lorem.characters(2) }
    code { Faker::Number.number(3) }
    value { Faker::Address.city }
    type { 'CodeMapping::LastVisitReason' }
  end

  factory :assigned_worker_mapping, class: 'CodeMapping::AssignedWorker' do
    key { Faker::Lorem.characters(2) }
    code { Faker::Number.number(3) }
    value { Faker::Address.city }
    type { 'CodeMapping::AssignedWorker' }
  end
end
