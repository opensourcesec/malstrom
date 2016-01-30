require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get indicators" do
    get :indicators
    assert_response 302
  end

end
