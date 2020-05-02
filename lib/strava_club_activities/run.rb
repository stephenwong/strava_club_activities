# frozen_string_literal: true

module StravaClubActivities
  class Run
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

    def generate_calculated_fields
      @distance = covert_distance_to_km(@raw_distance)
      @moving_time = covert_secs_to_time(@raw_moving_time)
      @elapsed_time = covert_secs_to_time(@raw_elapsed_time)
      @moving_percentage = calc_moving_percentage(@raw_moving_time, @raw_elapsed_time)
      @average_pace = calc_average_pace(@raw_distance, @raw_moving_time)
    end

    def covert_distance_to_km(raw_distance)
      (raw_distance.to_f / 1000.0).round(4) unless raw_distance.nil?
    end

    def covert_secs_to_time(seconds)
      Time.at(seconds).utc.strftime('%H:%M:%S') unless seconds.nil?
    end

    def calc_moving_percentage(raw_moving_time, raw_elapsed_time)
      (raw_moving_time.to_f / raw_elapsed_time * 100.0).round(2) unless raw_moving_time.nil? || raw_elapsed_time.nil?
    end

    def calc_average_pace(raw_distance, raw_moving_time)
      Time.at(1000.0 / raw_distance * raw_moving_time).round(2).utc.strftime('%M:%S.%L') unless raw_distance.nil? || raw_moving_time.nil?
    end

    def to_array
      [@name, @run_title, @average_pace, @distance, @moving_time, @elapsed_time, @moving_percentage, @elevation, @raw_distance, @raw_moving_time, @raw_elapsed_time]
    end
  end
end
