class Survivor < ActiveRecord::Base
  has_one :last_location
  has_one :inventory
  has_many :resources, :through => :inventory

  validates_presence_of :name, :age, :gender

  accepts_nested_attributes_for :last_location
end
