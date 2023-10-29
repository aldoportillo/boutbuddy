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

  has_many :weight_classes, class_name: "weight_class_id", foreign_key: "weight_class_id"
end
