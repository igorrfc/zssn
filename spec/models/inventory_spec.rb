require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:survivor_id) }

    context 'associations' do
      it { is_expected.to belong_to(:survivor) }
      it { is_expected.to have_many(:resources) }
    end
  end
end
