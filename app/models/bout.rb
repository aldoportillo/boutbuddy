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
  belongs_to :red_corner, class_name: 'User', foreign_key: 'red_corner_id'
  belongs_to :blue_corner, class_name: 'User',  foreign_key: 'blue_corner_id'

  belongs_to :weight_class
  
end
