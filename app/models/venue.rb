# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  lat        :float
#  lng        :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Venue < ApplicationRecord
end
