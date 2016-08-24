class Survivor < ActiveRecord::Base
  validates_presence_of :name, :age, :gender

  has_one :last_location, class_name: "LastLocation"
  has_one :inventory
end
