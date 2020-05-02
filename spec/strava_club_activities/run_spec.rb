# frozen_string_literal: true

require_relative '../../lib/strava_club_activities/run'

RSpec.describe StravaClubActivities::Run do
  let(:run) { described_class.new({ 'athlete' => {} }) }

  describe '#covert_distance_to_km' do
    it 'rounds it to 4 decimal places' do
      expect(run.covert_distance_to_km(12_345.67)).to eq(12.3457)
    end
  end

  describe '#covert_secs_to_time' do
    it 'can do under 60 secs' do
      expect(run.covert_secs_to_time(55)).to eq('00:00:55')
    end

    it 'can do under 60 mins' do
      expect(run.covert_secs_to_time(3155)).to eq('00:52:35')
    end

    it 'can do beyond 60 mins' do
      expect(run.covert_secs_to_time(1_115_123)).to eq('21:45:23')
    end
  end

  describe '#calc_moving_percentage' do
    it 'rounds to 2 decimal places' do
      expect(run.calc_moving_percentage(1630, 1632)).to eq(99.88)
    end
  end

  describe '#calc_average_pace' do
    it 'rounds to 2 decimal places' do
      expect(run.calc_average_pace(10_000, 2503)).to eq('04:10.300')
    end
  end
end
