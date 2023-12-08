# config/schedule.rb

every :sunday, at: '2:00 am' do
  runner "DestroyPreviousDataJob.perform_later"
end

every :sunday, at: '2:15 am' do
  runner "GenerateWeightClassesJob.perform_later"
end

every :sunday, at: '2:30 am' do
  runner "GenerateUsersJob.perform_later"
end

every :sunday, at: '2:45 am' do
  runner "GenerateVenuesJob.perform_later"
end

every :sunday, at: '3:00 am' do
  runner "GenerateEventsJob.perform_later"
end

every :sunday, at: '3:15 am' do
  runner "GenerateSwipesJob.perform_later"
end

every :sunday, at: '3:30 am' do
  runner "GenerateBoutsJob.perform_later"
end

every :sunday, at: '3:45 am' do
  runner "GenerateMessagesJob.perform_later"
end

every :sunday, at: '4:00 am' do
  runner "GenerateWinByMethodsJob.perform_later"
end

every :sunday, at: '4:15 am' do
  runner "GeneratePastEventsJob.perform_later"
end

# Example of logging output
set :output, "log/cron_log.log"

# Load the Rails environment
set :environment, "production"
