# frozen_string_literal: true

module StravaClubActivities
  module Calculations
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
      Time.at(1000.0 / raw_distance * raw_moving_time).round(1).utc.strftime('%M:%S.%L') unless raw_distance.nil? || raw_moving_time.nil?
    end
  end
end
