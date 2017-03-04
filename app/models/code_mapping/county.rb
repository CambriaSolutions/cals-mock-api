class CodeMapping::County < CodeMapping::Base
  has_many :facilities, :class_name => 'Facility', :foreign_key => 'fac_co_nbr'
end
