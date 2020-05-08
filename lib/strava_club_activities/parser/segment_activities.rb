# frozen_string_literal: true

require_relative '../models/segment_run'
require_relative '../models/segment'

module StravaClubActivities
  module Parser
    class SegmentActivities
      attr_reader :targeted_segment
      def initialize(logger)
        @runs = []
        @logger = logger
        @targeted_segment = nil
      end

      def parse_starred_segments(raw_data, segment_filter)
        @logger.info "Trying to find a segment called with #{segment_filter} in the #{raw_data.count} starred segments..."
        segments = []
        raw_data.each do |run|
          segments << StravaClubActivities::Models::Segment.new(run)
        end
        results = segments.select { |x| x.name.downcase.include?(segment_filter.downcase) }
        raise ArgumentError, "No segments named #{segment_filter}" if results.empty?

        @targeted_segment = results.first
        @logger.info "Segment #{@targeted_segment.name} found with distance of #{@targeted_segment.distance}"
      end

      def parse_leaderboard(raw_data)
        @logger.info 'Parsing today\'s leaderboard data for segment...'
        raw_data['entries'].each do |run|
          @runs << StravaClubActivities::Models::SegmentRun.new(run, @targeted_segment.distance)
        end
      end

      def to_csv(filename)
        filename = 'segment_race.csv' if filename.nil?
        @logger.info "Generating CSV to #{filename}..."
        CSV.open(filename, 'w') do |csv|
          csv << StravaClubActivities::Models::SegmentRun.column_names
          count = 0
          @runs.each do |run|
            count += 1
            csv << run.to_array
          end
          @logger.info "Final count of #{count} activities"
        end
      end
    end
  end
end
