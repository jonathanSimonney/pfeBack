class Api::Map::InterestPoints::InterestPointController < ApplicationController
  MAX_DISTANCE_TO_DISPLAY = 200 # in km

  def find_by
    latitude = params['lat'].convert_to_decimal
    longitude = params['lng'].convert_to_decimal

    interest_points = InterestPoint.within(MAX_DISTANCE_TO_DISPLAY, :origin => [latitude, longitude])
    positions = Position.within(MAX_DISTANCE_TO_DISPLAY, :origin => [latitude, longitude])
    render :json => {:interest_points => interest_points, :positions => positions}
  end
end
