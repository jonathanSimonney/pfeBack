# frozen_string_literal: true

class Api::Map::InterestPoints::InterestPointController < ApplicationController
  MAX_DISTANCE_TO_DISPLAY = 200 # in km
  MAX_TIME_SINCE_LAST_SHARE = 24.hours

  def find_by
    now = Time.now

    latitude = params['lat'].convert_to_decimal
    longitude = params['lng'].convert_to_decimal

    interest_points = InterestPoint.within(MAX_DISTANCE_TO_DISPLAY, origin: [latitude, longitude])
    positions = Position.within(MAX_DISTANCE_TO_DISPLAY, origin: [latitude, longitude])

    recent_positions = positions.select { |position| position.shared_at > now - MAX_TIME_SINCE_LAST_SHARE }

    ret = []

    for interest_point in interest_points
      opinion_list = InterestPointOpinion.where(interest_point_id: interest_point["id"])
      average_grade = opinion_list.inject(0) { |sum, el| sum + el['grade'] }.to_f / opinion_list.size
      ret.push({interest_point: interest_point, opinions: opinion_list, average_grade: average_grade})
    end

    render json: { interest_points: ret, positions: recent_positions }
  end
end
