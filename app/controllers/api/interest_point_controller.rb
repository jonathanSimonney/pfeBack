class Api::InterestPointController < ApplicationController
  MAX_DISTANCE_TO_DISPLAY = 200 # in km

  def find_by
    latitude = params['lat']
    longitude = params['lng']

    ret = InterestPoint.within(MAX_DISTANCE_TO_DISPLAY, :origin => [latitude, longitude])
    render :json => ret
  end
end
