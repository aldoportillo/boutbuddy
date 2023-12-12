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

# Result is a model that represents a result of a bout.
class Result < ApplicationRecord
  # A result belongs to a bout
  belongs_to :bout
  # A result belongs to a winner, which is a type of user
  belongs_to :winner, class_name: :User, foreign_key: :winner_id
  # A result belongs to a win_by, which is a type of WinBy
  belongs_to :win_by, class_name: :WinBy, foreign_key: :win_by_id
end
