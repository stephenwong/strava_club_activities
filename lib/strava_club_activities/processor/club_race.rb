# frozen_string_literal: true

require_relative '../parser/club_activities'

module StravaClubActivities
  module Processor
    class ClubRace
      def initialize(logger, api, filter, filename)
        @logger = logger
        @api = api
        @parser = StravaClubActivities::Parser::ClubActivities.new(logger, filter)
        @filename = filename
      end

      def process
        data = @api.get_club_activities
        @parser.parse(JSON.parse(data.body))
        @parser.to_csv(@filename)
        @logger.info 'Done!'
      end
    end
  end
end
