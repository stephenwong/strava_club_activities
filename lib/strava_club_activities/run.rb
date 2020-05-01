# frozen_string_literal: true

class Run
  attr_reader :name, :run_title, :raw_moving_time, :raw_elapsed_time, :elevation, :type
  def initialize(hash)
    @name = "#{hash['athlete']['firstname']} #{hash['athlete']['lastname']}"
    @run_title = hash['name']
    @raw_distance = hash['distance']
    @raw_moving_time = hash['moving_time']
    @raw_elapsed_time = hash['elapsed_time']
    @distance = (@raw_distance.to_f / 1000.0).round(3)
    @moving_time = Time.at(@raw_moving_time).utc.strftime('%H:%M:%S')
    @elapsed_time = Time.at(@raw_elapsed_time).utc.strftime('%H:%M:%S')
    @moving_percentage = (@raw_moving_time.to_f / @raw_elapsed_time).round(2) * 100
    @elevation = hash['total_elevation_gain']
    @type = hash['type']
  end

  def to_array
    [@name, @run_title, @distance, @moving_time, @elapsed_time, @moving_percentage, @elevation, @raw_distance, @raw_moving_time, @raw_elapsed_time]
  end
end
