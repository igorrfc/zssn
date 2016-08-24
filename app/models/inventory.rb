class Inventory < ActiveRecord::Base
  belongs_to :survivor
  has_many :resources
end
