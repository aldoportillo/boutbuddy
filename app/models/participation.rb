# == Schema Information
#
# Table name: participations
#
#  id         :bigint           not null, primary key
#  corner     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bout_id    :integer
#  user_id    :integer
#

# Participation is a model that represents a participation.
# It is an association between a user (fighter) and a bout.
class Participation < ApplicationRecord
  # A participation belongs to a user (fighter)
  belongs_to :user
  # A participation belongs to a bout
  belongs_to :bout
end
