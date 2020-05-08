# frozen_string_literal: true

require_relative '../parser/segment_activities'

module StravaClubActivities
  module Processor
    class SegmentRace
      def initialize(logger, api, filter, filename)
        @logger = logger
        @api = api
        @parser = StravaClubActivities::Parser::SegmentActivities.new(logger)
        @filename = filename
        @filter = filter
      end

      def process
        starred_segments_data = @api.get_starred_segments
        @parser.parse_starred_segments(JSON.parse(starred_segments_data.body), @filter)
        segment_leaderboard_data = @api.get_segment_leaderboard(@parser.targeted_segment.id)
        @parser.parse_leaderboard(JSON.parse(segment_leaderboard_data.body))
        @parser.to_csv(@filename)
        @logger.info 'Done!'
      end
    end
  end
end
