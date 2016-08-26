require 'rails_helper'

RSpec.describe Api::InfectedReportsController, type: :controller do
  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @survivor = FactoryGirl.create :survivor
        post :create, { survivor: { survivor_id: @survivor.id } }, format: :json
      end

      it 'renders the json representation for the created report' do
        report_response = JSON.parse(response.body, symbolize_names: true)
        expect(report_response[:survivor_id]).to eql @survivor.id
      end

      it 'must respond with 201 status' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when has problems' do
      before(:each) do
        post :create, { survivor: { survivor_id: 5023 } }, format: :json
      end

      it 'must respond with 404 status when survivor not found' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
