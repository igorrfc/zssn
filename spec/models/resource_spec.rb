require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:inventory_id) }
    it { is_expected.to validate_presence_of(:resource_type_id) }

    context 'associations' do
      it { is_expected.to belong_to(:inventory) }
      it { is_expected.to belong_to(:resource_type) }
    end
  end
end
