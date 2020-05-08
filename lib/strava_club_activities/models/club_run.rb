# frozen_string_literal: true

require_relative '../calculations'

module StravaClubActivities
  module Models
    class ClubRun
      include Calculations

      attr_reader :name, :run_title, :raw_moving_time, :raw_elapsed_time, :elevation, :type

      def initialize(hash)
        @name = "#{hash['athlete']['firstname']} #{hash['athlete']['lastname']}"
        @run_title = hash['name']
        @raw_distance = hash['distance']
        @raw_moving_time = hash['moving_time']
        @raw_elapsed_time = hash['elapsed_time']
        @elevation = hash['total_elevation_gain']
        @type = hash['type']
        generate_calculated_fields
      end

      def self.column_names
        %w[athlete run_title average_pace_(min/km) distance_(km) moving_time elapsed_time moving_% elevation_(m) raw_distance raw_moving_time raw_elapsed_time]
      end

      def to_array
        [@name, @run_title, @average_pace, @distance, @moving_time, @elapsed_time, @moving_percentage, @elevation, @raw_distance, @raw_moving_time, @raw_elapsed_time]
      end
    end
  end
end
