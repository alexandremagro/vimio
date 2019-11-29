require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @video = videos(:one)
  end

  test "can get index" do
    get videos_url

    assert_response :success
  end

  test "can get show" do
    get video_url(@video)

    assert_response :success
  end

  test "can increment view count" do
    assert_difference -> { @video.reload.view_count } do
      post view_video_url(@video)

      assert_response :success
    end
  end
end
