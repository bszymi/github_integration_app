# frozen_string_literal: true

Sidekiq.configure_server do |_config|
  schedule_file = 'config/schedule.yml'

  Sidekiq::Scheduler.reload_schedule! if File.exist?(schedule_file) && Sidekiq.server?
end
