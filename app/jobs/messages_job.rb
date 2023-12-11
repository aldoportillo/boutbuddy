class MessagesJob < ApplicationJob
  queue_as :default

  def perform
    pp "Generating Messages"

    events = Event.all

    events.each do |event|
      participating_users = User.joins(:participations).where(participations: { bout: event.bouts }).distinct
      participating_users.each do |user|
        Message.create!(
          user: user,
          event: event,
          content: Faker::Quote.most_interesting_man_in_the_world
        )
      end
    end

    pp "There are now #{Message.count} messages."
  end
end
