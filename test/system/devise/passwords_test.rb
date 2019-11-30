require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  def setup
    @user = users(:johnny)
  end

  def teardown
    logout
  end

  # create

  test "can request an reset password instructions email" do
    assert_difference "ActionMailer::Base.deliveries.size" do
      request_reset_password(@user.email)
    end
  end

  # update

  test "can update password with reset password token" do
    request_reset_password(@user.email)
    visit last_email_link("Change my password")

    assert_changes -> { @user.reload.encrypted_password } do
      fill_in "New password", with: Const::USER_PASSWORD.reverse
      fill_in "Confirm new password", with: Const::USER_PASSWORD.reverse
      click_button "Change my password"

      assert_text t('devise.passwords.updated')
    end
  end

  test "cannot update password without reset password token" do
    visit edit_user_password_path
    assert_text t('devise.passwords.no_token')
  end

  private

  def request_reset_password(email)
    visit root_path

    within(Selectors::TITLEBAR) { click_link "Sign in" }
    within(Selectors::MAIN_CONTENT) { click_link "Forgot your password?" }
    fill_in "Email", with: email
    click_button "Reset password"

    assert_text t('devise.passwords.send_instructions')
  end
end
