# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  bio         :string
#  photo       :string
#  price       :integer
#  time        :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  promoter_id :integer
#  venue_id    :integer
#

# Event is a model that represents an event.
class Event < ApplicationRecord
  # An event belongs to a venue
  belongs_to :venue
  # An event belongs to a promoter, which is a type of user
  belongs_to :promoter, class_name: :User, foreign_key: :promoter_id

  # An event has many bouts
  has_many :bouts, class_name: "Bout", foreign_key: "event_id", dependent: :destroy
  # An event has many fighters through bouts
  has_many :fighters, through: :bouts

  # An event has many messages
  has_many :messages, class_name: "Message", foreign_key: "event_id", dependent: :destroy

  # ransackable_attributes is a class method that returns the attributes that can be searched with Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["time", "price"]
  end
end
