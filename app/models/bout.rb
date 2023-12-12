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

# Bout is a model that represents a fight in an event.
class Bout < ApplicationRecord
  # A bout belongs to an event
  belongs_to :event
  # A bout has one result
  has_one :result

  # A bout has many participations (associations between fighters and bouts)
  has_many :participations
  # A bout has many fighters through participations
  has_many :fighters, through: :participations, source: :user

  # red_corner_fighter is a method that returns the fighter in the red corner for this bout
  def red_corner_fighter
    fighters.joins(:participations).find_by(participations: { corner: 'red' })
  end

  # blue_corner_fighter is a method that returns the fighter in the blue corner for this bout
  def blue_corner_fighter
    fighters.joins(:participations).find_by(participations: { corner: 'blue' })
  end

  # A bout belongs to a weight class
  belongs_to :weight_class
end
