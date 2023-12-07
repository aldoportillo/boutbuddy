if Rails.env.production?
  SampleDataJob.perform_async
end
