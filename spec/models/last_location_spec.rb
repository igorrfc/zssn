require 'rails_helper'

RSpec.describe LastLocation, type: :model do

  describe 'validations' do
    it 'requires a latitude' do
      subject.latitude = nil
      subject.valid?
      expect(subject.errors[:latitude].size).to eq(1)
    end

    it 'requires a longitude' do
      subject.longitude = nil
      subject.valid?
      expect(subject.errors[:longitude].size).to eq(1)
    end

    context 'associations' do
      it 'belong to survivor' do
        last_location = LastLocation.reflect_on_association(:survivor)
        expect(last_location.macro).to eql(:belongs_to)
      end
    end
  end
end
