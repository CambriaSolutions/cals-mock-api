require 'rails_helper'

RSpec.describe V1::FacilitiesController, type: :controller do

  let!(:facility) { FactoryGirl.create(:facility) }

  describe 'GET index' do
    it 'assigns @facilities' do
      get :index

      expect(assigns(:facilities)).to eq([facility])
    end

    it 'is successful' do
      get :index

      expect(response).to be_success
    end

    it 'renders the json response' do
      get :index
      expect(response.body).to eq [facility].to_json
    end
  end

  describe 'GET show' do
    it 'renders the json response with factory' do
      get :show, params: {id: facility.id}

      expect(response.body).to eq facility.to_json
    end

    it 'renders error message' do
      get :show, params: {id: 3}

      expect(response.body).to eq({message: "Couldn't find Facility with 'id'=3"}.to_json)
    end
  end

  describe 'PUT Update' do
    it 'updates facility attributes' do
      put :update,  params: {id: facility.id, name: 'changed name', admin_name: 'changed admin name', capacity: 99,
          number: '278654'}

      parsed_response = JSON.parse response.body
      expect(parsed_response['name']).to eq 'changed name'
      expect(parsed_response['admin_name']).to eq 'changed admin name'
      expect(parsed_response['capacity']).to eq 99
      expect(parsed_response['number']).to eq '278654'
    end
  end

  describe 'DELETE Destroy' do
    it 'deletes facility' do
      expect { delete :destroy, params: {:id => facility.id }}.to change(Facility, :count).by(-1)
    end
    it 'throws error message ' do
      delete :destroy, params: {:id => 100}
      expect(response.body).to eq({message: "Couldn't find Facility with 'id'=100"}.to_json)
    end
  end
end
