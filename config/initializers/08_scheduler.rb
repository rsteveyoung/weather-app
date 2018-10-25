require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

# Run weather updater on load
WeatherUpdaterJob.perform_later()

# Schedule updater loop
scheduler.every '10s' do
  WeatherUpdaterJob.perform_later()
end