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
class Event < ApplicationRecord

  belongs_to :venue

  has_many :bouts, class_name: "Bout", foreign_key: "event_id"

  has_many :fighters, through: :bouts

  def self.ransackable_attributes(auth_object = nil)
    ["time", "price"]
  end

  has_many :messages, class_name: "Message", foreign_key: "event_id"


end
