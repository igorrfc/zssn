class Resource < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :resource_type

  validates_presence_of :inventory_id, :resource_type_id
end
