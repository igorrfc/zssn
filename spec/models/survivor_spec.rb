  require 'rails_helper'

RSpec.describe Survivor, type: :model do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:age) }
    it { is_expected.to validate_presence_of(:gender) }

    context 'associations' do
      it { is_expected.to have_one(:inventory) }
      it { is_expected.to have_one(:last_location) }
    end
  end
end
