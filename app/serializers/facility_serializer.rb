class FacilitySerializer < ActiveModel::Serializer
  attributes :fac_name, :fac_nbr, :fac_type,
             :fac_licensee_name, :fac_mail_street_addr,
             :fac_mail_city, :fac_mail_state,
             :fac_mail_zip_code, :fac_res_street_addr,
             :fac_res_city, :fac_res_state,
             :fac_res_zip_code, :fac_co_nbr,
             :facility_telephone, :fac_do_nbr, :fac_status,
             :fac_do_eval_code, :fac_licensee_type, :fac_lic_eff_date,
             :fac_last_visit_date, :fac_last_visit_reason,
             :fac_capacity, :fac_orig_appl_rec_date
end
