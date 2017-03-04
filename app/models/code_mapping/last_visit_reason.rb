class CodeMapping::LastVisitReason < CodeMapping::Base
  has_many :facilities, :class_name => 'Facility', :foreign_key => 'fac_last_visit_reason'
end
