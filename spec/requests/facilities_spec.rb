require 'rails_helper'

RSpec.describe 'Facilities API', type: :request do

  # initialize test data
  let!(:facilities) { create_list(:facility, 10) }
  let(:facility_id) { facilities.first.id }

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
    before { get "/v1/facilities/#{facility_id}" }

    context 'when the record exists' do
      it 'returns the faciltiy' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(facility_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record dosnt exist' do
      let(:facility_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Facility/)
      end
    end

  end

end
