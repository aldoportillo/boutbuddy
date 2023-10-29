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

  has_many :bouts, class_name: "Bouts", foreign_key: "user_id"
  has_many :messages, class_name: "Message", foreign_key: "user_id"
  
end
