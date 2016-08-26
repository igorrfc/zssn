require 'rails_helper'

RSpec.describe LastLocation, type: :model do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }

    context 'associations' do
      it { is_expected.to belong_to(:survivor) }
    end
  end
end
