class Api::Map::Position::PositionController < ApplicationController
  protect_from_forgery prepend: true
  def add
    @user = User.where(authentication_token: params[:token]).first
    @lng = params[:lng].convert_to_decimal
    @lat = params[:lat].convert_to_decimal

    if @user
      Position.find_or_initialize_by(:user_id => @user.id).update(:lng => @lng, :lat => @lat, :shared_at => Time.now)
    else
      puts "send error"
    end
  end
end