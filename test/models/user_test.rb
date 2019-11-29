require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "must contain name" do
    user = User.new

    assert_not user.valid?
    assert_equal ["can't be blank"], user.errors.messages[:name]
  end

  test "must contain a valid birthdate" do
    user = User.new(birthdate: Date.tomorrow)

    assert_not user.valid?
    assert_equal ["must be past"], user.errors.messages[:birthdate]
  end
end
