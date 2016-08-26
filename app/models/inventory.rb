class Inventory < ActiveRecord::Base
  belongs_to :survivor
  has_many :resources

  validates_presence_of :survivor_id
end
