  require 'rails_helper'

RSpec.describe Survivor, type: :model do

  describe 'validations' do
    let(:survivor) { FactoryGirl.create(:survivor) }

    it 'requires a name' do
      survivor.name = nil
      expect(survivor).to_not be_valid
    end

    it 'requires an age' do
      survivor.age = nil
      expect(survivor).to_not be_valid
    end

    it 'requires a gender' do
      survivor.gender = nil
      expect(survivor).to_not be_valid
    end

    context 'associations' do
      it 'have one inventory' do
        survivor = Survivor.reflect_on_association(:inventory)
        expect(survivor.macro).to eql(:has_one)
      end

      it 'have one last_location' do
        survivor = Survivor.reflect_on_association(:last_location)
        expect(survivor.macro).to eql(:has_one)
      end
    end
  end
end
