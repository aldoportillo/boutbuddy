# == Schema Information
#
# Table name: bouts
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_id        :integer
#  weight_class_id :integer
#
class Bout < ApplicationRecord

  belongs_to :event

  has_many :participations
  has_many :fighters, through: :participations, source: :user

  def red_corner_fighter
    fighters.joins(:participations).find_by(participations: { corner: 'red' })
  end

  def blue_corner_fighter
    fighters.joins(:participations).find_by(participations: { corner: 'blue' })
  end



  belongs_to :weight_class
  
end
