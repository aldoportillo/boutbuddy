# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  address    :string
#  lat        :float
#  lng        :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Venue < ApplicationRecord
  has_many :events, class_name: "Event", foreign_key: "event_id"
end
