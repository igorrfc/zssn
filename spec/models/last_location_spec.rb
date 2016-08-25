require 'rails_helper'

RSpec.describe LastLocation, type: :model do

  describe 'validations' do
    it 'requires a latitude' do
      subject.latitude = nil
      expect(subject).to_not be_valid
    end

    it 'requires a longitude' do
      subject.longitude = nil
      expect(subject).to_not be_valid
    end

    context 'associations' do
      it 'belong to survivor' do
        last_location = LastLocation.reflect_on_association(:survivor)
        expect(last_location.macro).to eql(:belongs_to)
      end
    end
  end
end
