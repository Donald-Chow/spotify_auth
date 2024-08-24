require "test_helper"

class SpotifyControllerTest < ActionDispatch::IntegrationTest
  test "should get authorize" do
    get spotify_authorize_url
    assert_response :success
  end
end
