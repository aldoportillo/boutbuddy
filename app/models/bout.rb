# == Schema Information
#
# Table name: bouts
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_id        :integer
#  weight_class_id :integer
#
class Bout < ApplicationRecord

  belongs_to :event

  has_many :participations
  has_many :users, through: :participations

  belongs_to :weight_class
  
end
