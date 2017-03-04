class Facility < ActiveRecord::Base
  self.table_name = 'facility_info_lis'

  belongs_to :county_mapping, :class_name => 'CodeMapping::County', :foreign_key => 'fac_co_nbr'
  belongs_to :district_office_mapping, :class_name => 'CodeMapping::DistrictOffice', :foreign_key => 'fac_do_nbr'
  belongs_to :status_mapping, :class_name => 'CodeMapping::FacilityStatus', :foreign_key => 'fac_status'
  belongs_to :type_mapping, :class_name => 'CodeMapping::FacilityType', :foreign_key => 'fac_type'
  belongs_to :last_visit_reason_mapping, :class_name => 'CodeMapping::LastVisitReason', :foreign_key => 'fac_last_visit_reason'

  def county
    county_mapping&.value
  end

  def district_office
    district_office_mapping&.value
  end

  def status
    status_mapping&.value
  end

  def type
    type_mapping&.value
  end

  def last_visit_reason
    last_visit_reason_mapping&.value
  end
end
