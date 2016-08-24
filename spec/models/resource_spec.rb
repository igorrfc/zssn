require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'validations' do
    it 'requires a description' do
      subject.description = nil
      subject.valid?
      expect(subject.errors[:description].size).to eq(1)
    end

    it 'requires a number of points' do
      subject.points = nil
      subject.valid?
      expect(subject.errors[:points].size).to eq(1)
    end

  end
end
