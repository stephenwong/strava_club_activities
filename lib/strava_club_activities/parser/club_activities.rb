# frozen_string_literal: true

require_relative '../models/club_run'

module StravaClubActivities
  module Parser
    class ClubActivities
      def initialize(logger, description_filter)
        @description_filter = description_filter
        @runs = []
        @logger = logger
      end

      def parse(raw_data)
        @logger.info 'Parsing all data...'
        raw_data.each do |run|
          @runs << StravaClubActivities::Models::ClubRun.new(run)
        end
      end

      def to_csv(filename)
        filename = 'club_race.csv' if filename.nil?
        @logger.info "Generating CSV to #{filename}..."
        CSV.open(filename, 'w') do |csv|
          csv << StravaClubActivities::Models::ClubRun.column_names
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
        result &&= run.run_title.downcase.include?(@description_filter.downcase) if !@description_filter.nil? && !@description_filter.empty?
        result
      end
    end
  end
end
