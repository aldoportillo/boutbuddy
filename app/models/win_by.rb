# == Schema Information
#
# Table name: win_bies
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# WinBy is a model that represents a method of winning.
class WinBy < ApplicationRecord
  # A method of winning can be associated with many results
  has_many :results
end
