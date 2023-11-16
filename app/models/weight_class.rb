# == Schema Information
#
# Table name: weight_classes
#
#  id         :integer          not null, primary key
#  max        :float
#  min        :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class WeightClass < ApplicationRecord
  has_many :bouts, class_name: "Bout", foreign_key: "weight_class_id"
  has_many :users

  has_many(:unmatched_bouts, -> {unconfirmed}, :class_name => "Bout", :foreign_key => "weight_class_id")
end
