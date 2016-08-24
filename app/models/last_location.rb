class LastLocation < ActiveRecord::Base
  validates_presence_of :latitude, :longitude

  belongs_to :survivor
end
