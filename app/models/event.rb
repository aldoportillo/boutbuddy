# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  bio        :string
#  price      :integer
#  time       :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  venue_id   :integer
#
class Event < ApplicationRecord
end
