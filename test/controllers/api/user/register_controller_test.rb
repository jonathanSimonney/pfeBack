# frozen_string_literal: true

require 'test_helper'

class Api::User::RegisterControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get api_user_register_new_url
    assert_response :success
  end
end
