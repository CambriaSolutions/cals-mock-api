class CodeMapping::DistrictOffice < CodeMapping::Base
  has_many :facilities, :class_name => 'Facility', :foreign_key => 'fac_do_nbr'
end
