require 'rails_helper'

RSpec.describe Api::SurvivorsController, type: :controller do

  describe 'GET #show' do
    before(:each) do
      @survivor = FactoryGirl.create :survivor
      get :show, id: @survivor.id, format: :json
    end

    it 'returns the information about a survivor on a hash' do
      survivor_response = JSON.parse(response.body, symbolize_names: true)
      expect(survivor_response[:gender]).to eql(@survivor.gender)
    end

    it 'must respond with 200 status' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @survivor_attributes = FactoryGirl.attributes_for :survivor
        @survivor_attributes['last_location_attributes'] = FactoryGirl.attributes_for :last_location
        post :create, { survivor: @survivor_attributes }, format: :json
      end

      it 'renders the json representation for the survivor record just created' do
        survivor_response = JSON.parse(response.body, symbolize_names: true)
        expect(survivor_response[:name]).to eql @survivor_attributes[:name]
      end

      it 'must respond with 201 status' do
        expect(response).to have_http_status(201)
      end

    end

    context 'does not create survivors' do
      before(:each) do
        @survivor_attributes = FactoryGirl.attributes_for :survivor
        post :create, { survivor: @survivor_attributes }, format: :json
      end

      context 'when survivor_attributes are null' do
        it 'must respond with 422 status' do
          expect(response).to have_http_status(422)
        end
      end

    end
  end

  describe 'PUT/PATCH #update' do
    context 'when last_location is successfully updated' do
      before(:each) do
        @survivor = FactoryGirl.create :survivor
        @survivor.last_location = FactoryGirl.create :last_location
        patch :update_location, { id: @survivor.id,
                         survivor: { last_location_attributes: { latitude: 15.77777, longitude: @survivor.last_location.longitude } } }, format: :json
      end

      it "renders the json representation for the updated survivor last_location" do
        survivor_response = JSON.parse(response.body, symbolize_names: true)
        expect(survivor_response[:latitude]).to eql 15.77777
      end

      it 'must respond with 200 status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when is not updated why have errors' do
      before(:each) do
        @survivor = FactoryGirl.create :survivor
        @survivor.last_location = FactoryGirl.create :last_location
        patch :update_location, { id: @survivor.id,
                         survivor: { last_location_attributes: { latitude: 15.77777, longitude: nil } } }, format: :json
      end

      it "renders an errors json" do
        survivor_response = JSON.parse(response.body, symbolize_names: true)
        expect(survivor_response).to have_key(:errors)
      end

      it "renders the json errors on whye the survivor could not be created" do
        survivor_response = JSON.parse(response.body, symbolize_names: true)
        expect(survivor_response[:errors][:longitude]).to include "can't be blank"
      end

    end
  end

  context 'when is not updated why couldnt find a survivor' do
    before(:each) do
      @survivor = FactoryGirl.create :survivor
      @survivor.last_location = FactoryGirl.create :last_location
      patch :update_location, { id: 70,
                       survivor: { last_location_attributes: { latitude: 15.77777, longitude: @survivor.last_location.longitude } } }, format: :json
    end

    it 'must respond with 404 status' do
      expect(response).to have_http_status(404)
    end
  end

end
