require 'rails_helper'

RSpec.describe Api::SurvivorsController, type: :controller do
  before(:all) do
    if ResourceType.all.count < 4
      Rails.application.load_seed
    end
  end

  describe 'GET #show' do
    before(:each) { request.headers['Accept'] = "application/api.zssn.v1, #{Mime::JSON}" }
    before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }
    before(:each) do
      @survivor = FactoryGirl.create :survivor
      get :show, id: @survivor.id
    end

    it 'returns the information about a survivor on a hash' do
      survivor_response = json_response
      expect(survivor_response[:gender]).to eql(@survivor.gender)
    end

    it 'must respond with 200 status' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) { request.headers['Accept'] = "application/api.zssn.v1, #{Mime::JSON}" }
      before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }
      before(:each) do
        @survivor_attributes = FactoryGirl.attributes_for :survivor
        @survivor_attributes['last_location_attributes'] = FactoryGirl.attributes_for :last_location
        post :create, { survivor: @survivor_attributes }, format: :json
      end

      it 'renders the json representation for the survivor record just created' do
        survivor_response = json_response
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
        survivor_response = json_response
        expect(survivor_response[:latitude]).to eql 15.77777
      end

      it 'must respond with status 200' do
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
        survivor_response = json_response
        expect(survivor_response).to have_key(:errors)
      end

      it "renders the json errors on whye the survivor could not be created" do
        survivor_response = json_response
        expect(survivor_response[:errors][:longitude]).to include "can't be blank"
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

  describe 'PUT/PATCH #trade' do
    before(:each) do
      @survivor1 = FactoryGirl.create :survivor
      @survivor1.create_inventory(survivor_id: @survivor1.id)
      @survivor2 = FactoryGirl.create :survivor
      @survivor2.create_inventory(survivor_id: @survivor2.id)
      @resource_1 = Resource.create(inventory_id: @survivor1.inventory.id, resource_type_id: 1)
      @resource_2 = Resource.create(inventory_id: @survivor2.inventory.id, resource_type_id: 2)
      @resource_3 = Resource.create(inventory_id: @survivor1.inventory.id, resource_type_id: 2)
    end

    context 'when successfully made' do
      before(:each) do
        patch :trade, { id: @survivor1.id, :resources => [ @resource_3.attributes ],
                                            :survivor => { id: @survivor2.id, :resources =>  [@resource_2.attributes] } }, format: :json
      end

      it 'must respond with 200 status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when has problems' do
      context 'with invalid survivors' do
        before(:each) do
          patch :trade, { id: 170 }, format: :json
        end
        it 'must respond with 404 status' do
          expect(response).to have_http_status(404)
        end
      end

      context 'with different resource value points' do
        before(:each) do
          patch :trade, { id: @survivor1.id, :resources => [ @resource_1.attributes ],
                                              :survivor => { id: @survivor2.id, :resources =>  [@resource_2.attributes] } }, format: :json
        end

        it 'must respond with 422 status' do
          expect(response).to have_http_status(422)
        end
      end

      context 'with invalid resources' do
        before(:each) do
          resource_x = Resource.create(id: 500, inventory_id: @survivor2.inventory.id, resource_type_id: 2)
          resource_y = Resource.create(id: 501, inventory_id: @survivor1.inventory.id, resource_type_id: 2)
          patch :trade, { id: @survivor1.id, :resources => [ resource_x.attributes ],
                                              :survivor => { id: @survivor2.id, :resources =>  [resource_y.attributes] } }, format: :json
        end

        it 'must respond with 422 status' do
          expect(response).to have_http_status(422)
        end
      end
    end

  end

end
