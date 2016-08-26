require 'rails_helper'

RSpec.describe Api::ReportsController, type: :controller do
  describe 'GET #infected_survivors' do
    context 'There are survivors' do
      before(:each) { request.headers['Accept'] = "application/api.zssn.v1, #{Mime::JSON}" }
      before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }
      before(:each) do
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        get :infected_survivors, {}
      end

      it 'returns the infected_survivors_percentage key' do
        report_response = json_response
        expect(report_response).to have_key(:infected_survivors_percentage)
      end

      it 'must respond with 200 status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'There are no survivors' do
      before(:each) do
        get :infected_survivors, {}
      end

      it 'must respond with 404 status' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #non_infected_survivors' do
    context 'There are survivors' do
      before(:each) { request.headers['Accept'] = "application/api.zssn.v1, #{Mime::JSON}" }
      before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }
      before(:each) do
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        get :non_infected_survivors, {}
      end

      it 'returns the non_infected_survivors_percentage key' do
        report_response = json_response
        expect(report_response).to have_key(:non_infected_survivors_percentage)
      end

      it 'must respond with 200 status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'There are no survivors' do
      before(:each) do
        get :non_infected_survivors, {}
      end

      it 'must respond with 404 status' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #resources_avg' do
    context 'There are survivors' do
      before(:each) { request.headers['Accept'] = "application/api.zssn.v1, #{Mime::JSON}" }
      before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }
      before(:each) do
        @resource_types_count = ResourceType.all.count
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        Survivor.create(FactoryGirl.attributes_for :survivor)
        get :resources_avg, {}
      end

      it 'must respond with 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'must respond with all resources listed' do
        report_response = json_response
        expect(report_response.length).to eql @resource_types_count
      end
    end

    context 'There are no survivors' do
      before(:each) { request.headers['Accept'] = "application/api.zssn.v1, #{Mime::JSON}" }
      before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }
      before(:each) do
        get :resources_avg, {}
      end

      it 'must respond with 404 status' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
