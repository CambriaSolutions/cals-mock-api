class CodeMapping::Base < ActiveRecord::Base
  self.table_name = 'cals_cvl'
  self.primary_key = 'code'

  scope :counties, -> { where(type: 'CodeMapping::County') }
  scope :facility_types, -> { where(type: 'CodeMapping::FacilityType') }
  scope :facility_statuses, -> { where(type: 'CodeMapping::FacilityStatus') }
  scope :last_visit_reasons, -> { where(type: 'CodeMapping::LastVisitReason') }
  scope :assigned_worker, -> { where(type: 'CodeMapping::AssignedWorker') }
end
