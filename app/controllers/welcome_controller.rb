# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    require './config/environment.rb' # Assuming the script is located in the root of the rails app
    begin
      ActiveRecord::Base.establish_connection # Establishes connection
      ActiveRecord::Base.connection # Calls connection object
      @connection_status = 'CONNECTED!' if ActiveRecord::Base.connected?
      @connection_status = 'NOT CONNECTED!' unless ActiveRecord::Base.connected?
    rescue StandardError
      @connection_status = 'NOT CONNECTED!'
    end
  end
end
