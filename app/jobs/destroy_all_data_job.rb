class DestroyAllDataJob < ApplicationJob
  queue_as :default

  def perform
    # Place the logic for destroying previous data here
    User.destroy_all
    Venue.destroy_all
    WeightClass.destroy_all
    Event.destroy_all
    Result.destroy_all
    Bout.destroy_all
    Message.destroy_all
    Swipe.destroy_all
    WinBy.destroy_all
    Participation.destroy_all
  end
end
