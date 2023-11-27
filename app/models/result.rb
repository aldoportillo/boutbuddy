# == Schema Information
#
# Table name: results
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bout_id    :bigint           not null
#  win_by_id  :integer
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
  belongs_to :winner, class_name: :User, foreign_key: :winner_id
  belongs_to :win_by, class_name: :WinBy, foreign_key: :win_by_id
end
