require 'rails_helper'

RSpec.describe 'Facilities API', type: :request do

  # initialize test data

  let!(:facilities) { create_list(:facility, 10) }
  let(:facility_number) { facilities.first.fac_nbr }

  # Test suite for GET /facilities
  describe 'GET /facilities' do

    # make HTTP get request before each example
    before { get '/v1/facilities' }

    it 'returns facilities' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET /facilities/:id' do
    before { get "/v1/facilities/#{facility_number}" }

    context 'when the record exists' do
      it 'returns the faciltiy' do
        expect(json).not_to be_empty
        expect(json['fac_nbr']).to eq(facility_number)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record dosnt exist' do
      let(:facility_number) { 100090 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Facility/)
      end
    end

  end

end
