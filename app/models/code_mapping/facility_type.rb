class CodeMapping::FacilityType < CodeMapping::Base
  has_many :facilities, :class_name => 'Facility', :foreign_key => 'fac_type'
end
