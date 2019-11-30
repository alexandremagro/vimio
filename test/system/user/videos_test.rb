require "application_system_test_case"

class VideosTest < ApplicationSystemTestCase
  def setup
    @user = users(:johnny)
    @video = @user.videos.first

    login_as @user
  end

  def teardown
    logout
  end

  # index

  test "can list own videos" do
    visit_my_videos

    within(Selectors::MAIN_CONTENT) do
      assert_selector Selectors::VIDEO_PREVIEW_TITLE, text: @video.name
    end
  end

  # create

  test "can create an video" do
    visit_my_videos

    within(Selectors::MAIN_CONTENT) do
      click_link "New video"

      assert_difference "Video.count" do
        fill_in "Name", with: "Hurt"
        fill_in "Url", with: "https://example.com/videos/2002.m3u8"
        click_button "Create Video"

        assert_selector Selectors::VIDEO_TITLE, text: 'Hurt'
      end
    end
  end

  # update

  test "can update an video" do
    visit_my_videos

    within(Selectors::MAIN_CONTENT) do
      find(Selectors::VIDEO_EDIT_BTN % { id: @video.id }).click

      assert_changes "@video.reload.name" do
        fill_in "Name", with: @video.name + '!'
        click_button "Update Video"

        assert_selector Selectors::VIDEO_PREVIEW_TITLE,
                        text: @video.name + '!'
      end
    end
  end

  # destroy

  test "can destroy an video" do
    visit_my_videos

    within(Selectors::MAIN_CONTENT) do
      assert_difference "Video.count", -1 do
        accept_confirm do
          find(Selectors::VIDEO_DELETE_BTN % { id: @video.id }).click
        end

        assert_no_selector Selectors::VIDEO_PREVIEW_TITLE, text: @video.name
      end
    end
  end

  private

  def visit_my_videos
    visit root_path
    within(Selectors::TITLEBAR) { click_link 'My videos' }
  end
end
