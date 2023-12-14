# == Schema Information
#
# Table name: venues
#
#  id          :bigint           not null, primary key
#  address     :string
#  lat         :float
#  lng         :float
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  promoter_id :integer
#

# Venue is a model that represents a venue.
class Venue < ApplicationRecord
  # Validate that the name and address are present before saving
  validates :name, :address, presence: true
  
  # A venue has many events
  has_many :events, class_name: "Event", foreign_key: "venue_id", dependent: :destroy
end
