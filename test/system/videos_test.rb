require "application_system_test_case"

class VideosTest < ApplicationSystemTestCase
  setup do
    @video = videos(:one)
  end

  # index

  test "can list all videos" do
    visit videos_url

    within(Selectors::MAIN_CONTENT) do
      assert_selector Selectors::VIDEO_PREVIEW_TITLE, text: @video.name
    end
  end

  # show

  test "can watch an video" do
    visit video_url(@video)

    assert_selector Selectors::VIDEO_TITLE, text: @video.name
  end

  # view

  test "can increment view count" do
    assert_difference "@video.reload.view_count" do
      visit video_url(@video)

      assert_selector Selectors::VIDEO_TITLE, text: @video.name
      assert_text @video.view_count + 1
    end
  end
end
