class DestroySwipesJob < ApplicationJob
  queue_as :default

  def perform
    Swipe.destroy_all
  end
end
