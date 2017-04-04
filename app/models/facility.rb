require 'elasticsearch/model'
class Facility < ActiveRecord::Base
  self.table_name = 'facility_info_lis'
  self.primary_key = 'fac_nbr'

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :county_mapping, :class_name => 'CodeMapping::County', :foreign_key => 'fac_co_nbr'
  belongs_to :district_office_mapping, :class_name => 'CodeMapping::DistrictOffice', :foreign_key => 'fac_do_nbr'
  belongs_to :status_mapping, :class_name => 'CodeMapping::FacilityStatus', :foreign_key => 'fac_status'
  belongs_to :type_mapping, :class_name => 'CodeMapping::FacilityType', :foreign_key => 'fac_type'
  belongs_to :last_visit_reason_mapping, :class_name => 'CodeMapping::LastVisitReason', :foreign_key => 'fac_last_visit_reason'
  belongs_to :assigned_worker_mapping, :class_name => 'CodeMapping::AssignedWorker', :foreign_key => 'fac_do_eval_code'

  mapping dynamic: 'false' do
    indexes :fac_res_street_addr, type: 'text'
    indexes :fac_res_city, type: 'text'
    indexes :fac_res_state, type: 'text'
    indexes :fac_res_zip_code, type: 'text'
    indexes :fac_type
    indexes :fac_nbr
    indexes :fac_name
    indexes :fac_co_nbr

    indexes :type_mapping do
      indexes :value, type: 'text',
       "index": 'not_analyzed'
    end
  end

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

  def assigned_worker
    assigned_worker_mapping&.value
  end

  def self.retrieve_search_results(query)
    Facility.search query: {multi_match: {query: query,
                                          type: 'cross_fields',
                                          minimum_should_match: '50%',
                                          fields: ['fac_nbr', 'fac_co_nbr', 'fac_type', 'fac_name' 'fac_res_street_addr','fac_res_city', 'fac_res_state'],
                                          lenient: true}}
  end
end
