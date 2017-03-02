class V1::FacilitiesController < ApplicationController
  before_action :find_facility, only: [:show, :destroy, :update]

  # GET /v1/facilities
  def index
    @facilities = Facility.where 'fac_nbr IS NOT NULL'
    json_response(@facilities)
  end

  # GET /v1/facilities/:id
  def show
    json_response(@facility)
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

  private
    def find_facility
      val = params[:id]
      @facility = Facility.find_by(fac_nbr: val)
    end

    def facility_params
      params.permit(:name, :admin_name, :capacity, :number, :approval_date)
    end
end
