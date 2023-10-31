# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  bio        :string
#  price      :integer
#  time       :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  venue_id   :integer
#
class Event < ApplicationRecord

  belongs_to :venue
  has_many :bouts, class_name: "Bout", foreign_key: "event_id"
  has_many :messages, class_name: "Message", foreign_key: "event_id"

  has_many(:red_corner_fighters, :through => "bouts", :source => "red_corner_fighter", :foreign_key => "red_corner_id")
  has_many(:blue_corner_fighters, :through => "bouts", :source => "blue_corner_fighter", :foreign_key => "blue_corner_id")

  # EVENT -> BOUTS > USER

end
