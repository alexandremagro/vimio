require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  test "must contain a name" do
    must_contain :name
  end

  test "must contain a url" do
    must_contain :url
  end

  private

  def must_contain(attribute)
    video = Video.new

    assert_not video.valid?
    assert_equal ["can't be blank"], video.errors.messages[attribute]
  end
end
