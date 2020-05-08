# frozen_string_literal: true

require 'httparty'

module StravaClubActivities
  class StravaApi
    include HTTParty
    default_options.update(verify: false)
    base_uri 'https://www.strava.com/api/'

    def initialize(logger, access_token, club_id)
      @logger = logger
      @access_token = access_token
      @club_id = club_id
    end

    def auth_header
      { headers: { 'Authorization' => "Bearer #{@access_token}" } }
    end

    def get_club_activities(page = 1)
      @logger.info 'Calling Strava API - List Club Activities'
      data = self.class.get("/v3/clubs/#{@club_id}/activities?&page=#{page}&per_page=200", auth_header)
      error_check(data)
      data
    end

    def get_starred_segments
      @logger.info 'Calling Strava API - Get Star Segments'
      data = self.class.get('/v3/segments/starred?&page=1&per_page=50', auth_header)
      error_check(data)
      data
    end

    def get_segment_leaderboard(id)
      @logger.info 'Calling Strava API - Get Segment Leaderboard for today'
      data = self.class.get("/v3/segments/#{id}/leaderboard?&club_id=#{@club_id}&date_range=today&page=1&per_page=200", auth_header)
      error_check(data)
      data
    end

    def error_check(data)
      @logger.info "Calling Strava API - Received status code #{data.code} - #{data.response.message}"
      if data.code >= 300
        @logger.error 'Request failed!'
        @logger.error data
      end
    end
  end
end
