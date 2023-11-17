# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  corner     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bout_id    :integer
#  user_id    :integer
#
class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :bout
end
