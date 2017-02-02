class V1::FacilitiesController < ApplicationController

  # GET /v1/facilities
  def index
    @facilities = Facility.all
    json_response(@facilities)
  end


  # GET /v1/facilities/:id
  def show
    @faciltiy = Facility.find(params[:id])
    json_response(@faciltiy)
  end
end
