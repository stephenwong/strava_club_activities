# frozen_string_literal: true

require_relative '../calculations'
module StravaClubActivities
  module Models
    class SegmentRun
      include Calculations

      attr_reader :name, :raw_moving_time, :raw_elapsed_time, :start_date, :rank

      def initialize(hash, distance)
        @name = hash['athlete_name']
        @raw_moving_time = hash['moving_time']
        @raw_elapsed_time = hash['elapsed_time']
        @start_date = DateTime.parse(hash['start_date']) unless hash['start_date'].nil?
        @rank = hash['rank']
        @raw_distance = distance
        generate_calculated_fields
      end

      def self.column_names
        %w[athlete average_pace_(min/km) moving_time elapsed_time moving_% start_time rank raw_moving_time raw_elapsed_time]
      end

      def to_array
        [@name, @average_pace, @moving_time, @elapsed_time, @moving_percentage, @start_date, @rank, @raw_moving_time, @raw_elapsed_time]
      end
    end
  end
end
