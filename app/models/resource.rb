class Resource < ActiveRecord::Base
  validates_presence_of :description, :points
end
