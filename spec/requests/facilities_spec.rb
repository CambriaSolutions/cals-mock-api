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
        expect(json['error']).to eq "Couldn't find Facility"
      end
    end

  end

  describe 'POST /facilities/search', elasticsearch: true do

    let(:headers) {{'ACCEPT': 'application/json'}}

    before do
      prepare_indices
      post '/v1/facilities/search', params: search_params, headers: headers
    end

    context 'with valid search params' do
      let(:search_params) do
        "{\"query\" : { \"term\" : { \"fac_nbr\" : #{facilities.last.fac_nbr} }}}"
      end

      it 'returns facility matching search 50% criteria' do
        expect(json['facilities'][0]['fac_nbr']).to eq(facilities.last.fac_nbr)
      end
    end

    context 'with search params without a match' do
      let(:search_params) do
        "{\"query\" : { \"term\" : { \"fac_nbr\" : 123 }}}"
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq "Couldn't find Facility"
      end
    end

    context 'with invalid search params' do
      let(:search_params) do
        {
            'query':{
                'wrong_type_name':{
                    'query':'090',
                    'type':'cross_fields',
                    'minimum_should_match':'50%',
                    'fields':['fac_nbr', 'fac_res_city'],
                    'lenient':'true'
                }
            }
        }
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(500)
      end

      it 'returns a not found message' do
        expect(json['error']).to match /bad request/
      end
    end
  end

  describe 'GET /facilities/search', elasticsearch: true do

    let(:search_query) { "#{facilities.last.fac_name}" }

    before do
      prepare_indices
      get "/v1/facilities/search?query=#{search_query}"
    end

    context 'with a valid search string' do
      it 'returns matching facility' do
        expect(json[0]['fac_nbr']).to eq(facilities.last.fac_nbr)
      end
    end
  end
end
