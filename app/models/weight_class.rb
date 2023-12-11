# == Schema Information
#
# Table name: weight_classes
#
#  id         :bigint           not null, primary key
#  max        :float
#  min        :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# WeightClass is a model that represents a weight class.
class WeightClass < ApplicationRecord
  # A weight class has many bouts
  has_many :bouts, class_name: "Bout", foreign_key: "weight_class_id"
  # A weight class has many users (fighters)
  has_many :users
end
