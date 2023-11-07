# == Schema Information
#
# Table name: venues
#
#  id          :integer          not null, primary key
#  address     :string
#  lat         :float
#  lng         :float
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  promoter_id :integer
#
class Venue < ApplicationRecord
  validates :name, :address, presence: true
  
  has_many :events, class_name: "Event", foreign_key: "venue_id"
  
end
