# frozen_string_literal: true

require_relative 'run'

class Parser
  def initialize(logger, data, description_filter)
    @description_filter = description_filter
    @raw_data = data
    @runs = []
    @logger = logger
  end

  def parse
    @raw_data.each do |run|
      @runs << Run.new(run)
    end
  end

  def to_csv(filename = 'test.csv')
    CSV.open(filename, 'w') do |csv|
      csv << %w[athlete run_title distance_(km) moving_time elapsed_time moving_% elevation_(m) raw_distance raw_moving_time raw_elapsed_time]
      @logger.info "Initially #{@runs.count} activities"
      count = 0
      @runs.each do |run|
        if valid? run
          count += 1
          csv << run.to_array
        end
      end
      @logger.info "Final count of #{count} activities"
    end
  end

  def valid?(run)
    result = run.type == 'Run'
    if !@description_filter.nil? && !@description_filter.empty?
      result &&= run.run_title.downcase.include?(@description_filter.downcase)
    end
    result
  end
end
