class V1::FacilitiesController < ApplicationController
  before_action :find_facility, only: [:show, :destroy, :update]

  # GET /v1/facilities
  def index
    @facilities = Facility.includes(:county_mapping, :district_office_mapping, :status_mapping, :type_mapping, :last_visit_reason_mapping).all
    json_response(@facilities)
  end

  # GET /v1/facilities/:id
  def show
    if @facility
      json_response(@facility)
    else
      render json: {error: I18n.t('facilities_controller.facility_not_found')}, status: :not_found
    end
  end

  def update
    @facility.update_attributes(facility_params)
    json_response(@facility)
  end

  def create
    facility = Facility.new
    facility.update_attributes(facility_params)
    json_response(facility)
  end

  def destroy
    @facility.destroy
  end

  def search_query
    @facilities = Facility.search('query': {'query_string': {'query': search_params}}).records

    if @facilities.count > 0
      json_response @facilities
    else
      not_found_response
    end
  end

  def search_post
    begin
      @facilities = Facility.search(request.raw_post).records

      if @facilities.count > 0
        render json: @facilities, adapter: :json, meta: {total: @facilities.count}, status: :ok
      else
        not_found_response
      end
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
      render json: {error: I18n.t('facilities_controller.facility_not_found_bad_request', error: e.message)}, status: :internal_server_error
    end
  end

  private
  def find_facility
    val = params[:id]
    @facility = Facility.find_by(fac_nbr: val)
  end

  def facility_params
    params.permit(:name, :admin_name, :capacity, :number, :approval_date)
  end

  def search_params
    params.require('query')
  end
end
