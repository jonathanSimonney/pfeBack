# frozen_string_literal: true

class Api::Map::InterestPoints::InterestPointController < ApplicationController
  protect_from_forgery prepend: true
  respond_to :json

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

  def create_opinion
    @user = User.where(authentication_token: params[:token]).first

    if @user
      body = JSON.parse request.raw_post

      opinion = InterestPointOpinion.find_or_initialize_by(user_id: @user.id, interest_point_id: params[:interest_point_id])
      unless body['title'].nil?
        opinion.update(title: body['title'])
      end

      unless body['message'].nil?
        opinion.update(message: body['message'])
      end

      unless body['grade'].nil?
        opinion.update(grade: body['grade'].to_f)
      end

      opinion.update(updated_at: Time.now)

      render json: { result: 'success' }
    else
      render json: { error: 'wrong token' }, status: :unauthorized
    end
  end
end
