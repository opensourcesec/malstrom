require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  test "should get feeds" do
    get :feeds
    assert_response :success
  end

end
