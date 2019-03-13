class Api::Map::InterestPoints::InterestPointController < ApplicationController
  MAX_DISTANCE_TO_DISPLAY = 200 # in km
  MAX_TIME_SINCE_LAST_SHARE = 24.hours

  def find_by
    now = Time.now

    latitude = params['lat'].convert_to_decimal
    longitude = params['lng'].convert_to_decimal

    interest_points = InterestPoint.within(MAX_DISTANCE_TO_DISPLAY, :origin => [latitude, longitude])
    positions = Position.within(MAX_DISTANCE_TO_DISPLAY, :origin => [latitude, longitude])

    recent_positions = positions.select {|position| position.shared_at > now - MAX_TIME_SINCE_LAST_SHARE }
    render :json => {:interest_points => interest_points, :positions => recent_positions}
  end
end
