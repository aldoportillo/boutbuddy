# == Schema Information
#
# Table name: swipes
#
#  id         :integer          not null, primary key
#  like       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  swiped_id  :integer
#  swiper_id  :integer
#
class Swipe < ApplicationRecord
  belongs_to :swiper, class_name: 'User'
  belongs_to :swiped, class_name: 'User'
end
