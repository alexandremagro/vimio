require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  def setup
    @user = users(:johnny)
  end

  def teardown
    logout
  end

  # create

  test "can sign in" do
    visit root_path
    within(Selectors::TITLEBAR) { click_link 'Sign in' }
    within(Selectors::MAIN_CONTENT) do
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: Const::USER_PASSWORD
      click_button "Log in"
    end

    assert_selector Selectors::USER_MENU, text: @user.name
  end

  test "cannot sign in with wrong password" do
    visit root_path
    within(Selectors::TITLEBAR) { click_link 'Sign in' }
    within(Selectors::MAIN_CONTENT) do
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: Const::USER_PASSWORD + '_WRONG'
      click_button "Log in"

      assert_text 'Invalid Email or password.'
    end
  end

  # destroy

  test "can sign out" do
    login_as(@user)
    visit root_path
    within(Selectors::TITLEBAR) do
      click_link @user.name
      click_link "Log out"
    end

    assert_selector Selectors::PAGE_ALERT,
                    text: t('devise.sessions.signed_out')
  end
end
