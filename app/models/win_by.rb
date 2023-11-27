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
class WinBy < ApplicationRecord

  has_many :results

end