# == Schema Information
#
# Table name: swipes
#
#  id         :bigint           not null, primary key
#  like       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  swiped_id  :integer
#  swiper_id  :integer
#

# Swipe is a model that represents a swipe.
# It is an association between two users: the one who swipes (swiper) and the one who is swiped (swiped).
class Swipe < ApplicationRecord
  # A swipe belongs to a swiper, which is a type of user
  belongs_to :swiper, class_name: 'User'
  # A swipe belongs to a swiped, which is also a type of user
  belongs_to :swiped, class_name: 'User'
end
