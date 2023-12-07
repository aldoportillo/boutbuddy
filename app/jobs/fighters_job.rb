# to enuqueue: FightersJob.perform_later
# to run: bundle exec good_job start 
class FightersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    
  end
end
