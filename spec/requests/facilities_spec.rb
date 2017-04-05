require 'rails_helper'
include SearchHelper

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


  describe 'GET /facilities/search', elasticsearch: true do

    let(:search_query) { "#{facilities.last.fac_nbr}, #{facilities.last.fac_co_nbr}, #{facilities.last.fac_type}, #{facilities.last.fac_name}, #{facilities.last.fac_res_street_addr}, #{facilities.last.fac_res_city}, #{facilities.last.fac_res_state}" }

    before do
      prepare_indices
      get "/v1/facilities/search?query=#{search_query}"
    end

    context 'when 100% criteria match' do
      it 'returns matching facility' do
        expect(json).not_to be_empty

        expect(json[0]['fac_nbr']).to eq(facilities.last.fac_nbr)
      end
    end

    context 'when 50% criteria match' do
      let(:search_query) { "#{facilities.last.fac_nbr}, 000, 000, 'incorrect_name', #{facilities.last.fac_res_street_addr }, 'incorrect_city', 'incorrect_state'" }

      it 'returns facility matching search 100% criteria' do
        expect(json).not_to be_empty

        expect(json[0]['fac_nbr']).to eq(facilities.last.fac_nbr)
      end
    end

    context 'when 40% criteria match' do
      let(:search_query) { "000, 000, 000, 'incorrect_name', 'random_address', #{facilities.last.fac_res_city}, #{facilities.last.fac_res_state}" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Facility/)
      end
    end
  end
end
