# frozen_string_literal: true

module StravaClubActivities
  module Models
    class Segment
      attr_reader :id, :name, :distance
      def initialize(hash)
        @id = hash['id']
        @name = hash['name']
        @distance = hash['distance']
      end
    end
  end
end
