class ResourceType < ActiveRecord::Base
  validates_presence_of :description, :points
  has_many :resources
end
