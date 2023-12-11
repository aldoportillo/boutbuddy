# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#  user_id    :integer
#

# Message is a model that represents a message.
class Message < ApplicationRecord
  # A message belongs to an event
  belongs_to :event
  # A message belongs to a user
  belongs_to :user
end
