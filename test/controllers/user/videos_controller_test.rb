require 'test_helper'

class User::VideosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:johnny)
    @video = @user.videos.first
    @someone_else_video = users(:june).videos.first

    login_as @user
  end

  def teardown
    logout
  end

  # index

  test "should get index" do
    get user_videos_path
    assert_response :success
  end

  # new

  test "should get new" do
    get new_user_video_path
    assert_response :success
  end

  # create

  test "should create video" do
    assert_difference 'Video.count' do
      post user_videos_path, params: {
        video: {
          name: "Hurt",
          url: Const::VIDEO_URL
        }
      }
    end
  end

  # edit

  test "should get edit" do
    get edit_user_video_path(@video)
    assert_response :success
  end

  # update

  test "should update video" do
    assert_changes '@video.reload.name' do
      put user_video_path(@video), params: {
        video: {
          name: @video.name.upcase
        }
      }
    end
  end

  test "shouldn't update video that don't own" do
    assert_no_changes '@someone_else_video.reload.name' do
      put user_video_path(@someone_else_video), params: {
        video: {
          name: @someone_else_video.name.upcase
        }
      }

      assert_response :not_found
    end
  end

  # destroy

  test "should destroy video" do
    assert_difference 'Video.count', -1 do
      delete user_video_path(@video)
    end
  end

  test "shouldn't destroy video that don't own" do
    assert_no_difference 'Video.count' do
      delete user_video_path(@someone_else_video)

      assert_response :not_found
    end
  end
end
