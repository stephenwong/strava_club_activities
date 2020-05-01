# frozen_string_literal: true

require 'httparty'

class StravaApi
  include HTTParty
  default_options.update(verify: false)
  base_uri 'https://www.strava.com/api/'

  def initialize(access_token, club_id)
    @access_token = access_token
    @club_id = club_id
  end

  def auth_header
    { headers: { 'Authorization' => "Bearer #{@access_token}" } }
  end

  def get_club_activities(page = 1)
    self.class.get("/v3/clubs/#{@club_id}/activities?&page=#{page}&per_page=200", auth_header)
  end
end
