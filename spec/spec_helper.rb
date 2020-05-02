# frozen_string_literal: true

require 'simplecov'

SimpleCov.root(File.expand_path('..', __dir__))
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.root 'lib'
SimpleCov.coverage_dir '../coverage'
SimpleCov.start do
  add_filter '/.bundle/'
end

require 'bundler/setup'
require 'strava_club_activities'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
