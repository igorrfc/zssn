require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'validations' do
    context 'associations' do
      it 'belong to survivor' do
        inventory = Inventory.reflect_on_association(:survivor)
        expect(inventory.macro).to eql(:belongs_to)
      end

      it 'has many resources' do
        inventory = Inventory.reflect_on_association(:resources)
        expect(inventory.macro).to eql(:has_many)
      end
    end
  end
end
