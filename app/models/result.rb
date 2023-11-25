# == Schema Information
#
# Table name: results
#
#  id         :bigint           not null, primary key
#  win_by     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bout_id    :bigint           not null
#  winner_id  :integer
#
# Indexes
#
#  index_results_on_bout_id  (bout_id)
#
# Foreign Keys
#
#  fk_rails_...  (bout_id => bouts.id)
#
class Result < ApplicationRecord
  belongs_to :bout
end
