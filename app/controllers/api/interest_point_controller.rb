class Api::InterestPointController < ApplicationController
  MaxDistanceToDisplay = 200 # in km

  def find_by
    latitude = params['lat']
    longitude = params['lng']

    ret = InterestPoint.within(MaxDistanceToDisplay, :origin => [latitude, longitude])
    render :json => ret
  end
end
