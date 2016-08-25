require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'validations' do
    it 'requires a description' do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it 'requires a number of points' do
      subject.points = nil
      expect(subject).to_not be_valid
    end

  end
end
