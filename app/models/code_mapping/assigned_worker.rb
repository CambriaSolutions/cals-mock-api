class CodeMapping::AssignedWorker < CodeMapping::Base
  has_many :facilities, :class_name => 'Facility', :foreign_key => 'fac_do_eval_code'
end
