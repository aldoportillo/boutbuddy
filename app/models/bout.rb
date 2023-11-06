# == Schema Information
#
# Table name: bouts
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  blue_corner_id  :integer
#  event_id        :integer
#  red_corner_id   :integer
#  weight_class_id :integer
#
class Bout < ApplicationRecord

  belongs_to :event
  belongs_to :weight_class

  belongs_to :red_corner_fighter, class_name: "User", foreign_key: "red_corner_id"
  belongs_to :blue_corner_fighter, class_name: "User", foreign_key: "blue_corner_id"


  scope :unconfirmed, -> { where('blue_corner_id == :val', val: 1) }
  scope :confirmed, -> { where('blue_corner_id != :val', val: 1) }
end
