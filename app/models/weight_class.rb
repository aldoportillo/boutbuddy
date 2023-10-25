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
end
