# frozen_string_literal: true

require 'test_helper'

class AppstoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get appstore_index_url
    assert_response :success
  end
end
