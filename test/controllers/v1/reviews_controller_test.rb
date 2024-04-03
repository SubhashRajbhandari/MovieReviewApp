require "test_helper"

class V1::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_reviews_index_url
    assert_response :success
  end
end
