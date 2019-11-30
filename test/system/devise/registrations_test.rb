require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  def setup
    @user = users(:johnny)
  end

  def teardown
    logout
  end

  # create

  test "can create an account" do
    visit_signup
    signup_form "Bob Dylan",
                "dylan@vimio.com",
                "password",
                "password"

    assert_selector Selectors::PAGE_ALERT,
                    text: t('devise.registrations.signed_up')
  end

  test "cannot create an account without password" do
    visit_signup
    signup_form "Bob Dylan",
                "dylan@vimio.com",
                nil,
                nil

    assert_selector Selectors::INVALID_FEEDBACK,
                    text: "Password can't be blank"
  end

  test "cannot create an account with wrong password confirmation" do
    visit_signup
    signup_form "Bob Dylan",
                "dylan@vimio.com",
                "password",
                "pass"

    assert_selector Selectors::INVALID_FEEDBACK,
                    text: "Password confirmation doesn't match Password"
  end

  # update

  test "can update account infos" do
    login_as @user
    visit_settings

    assert_changes "@user.name" do
      assert_changes "@user.birthdate" do
        assert_changes "@user.reload.gender" do
          # name
          fill_in "Name", with: "Anonymous"

          # birthdate
          select 'January', from: 'user_birthdate_2i'
          select '1', from: 'user_birthdate_3i'
          select '1990', from: 'user_birthdate_1i'

          # gender
          choose 'Not applicable'

          fill_in "Current password", with: Const::USER_PASSWORD
          click_button "Save changes"
        end
      end
    end
  end

  test "can update password" do
    login_as @user
    visit_settings

    assert_changes "@user.reload.encrypted_password" do
      fill_in "Password", with: Const::USER_PASSWORD.reverse
      fill_in "Password confirmation", with: Const::USER_PASSWORD.reverse
      fill_in "Current password", with: Const::USER_PASSWORD
      click_button "Save changes"
    end
  end

  test "cannot update account without current password" do
    login_as @user
    visit_settings

    assert_no_changes "@user.reload.name" do
      fill_in "Name", with: "Anonymous"
      click_button "Save changes"

      assert_selector Selectors::INVALID_FEEDBACK,
                      text: "Current password can't be blank"
    end
  end

  # destroy

  test "can cancel account" do
    user = User.create! name: "Test",
                        email: "test@vimio.com",
                        password: Const::USER_PASSWORD

    login_as user
    visit_settings

    click_link "Cancel account"
    accept_confirm do
      click_button "Cancel my account"
    end

    assert_selector Selectors::PAGE_ALERT,
                    text: t('devise.registrations.destroyed')
  end

  private

  def visit_signup
    visit root_path
    within(Selectors::TITLEBAR) { click_link "Sign in" }
    within(Selectors::MAIN_CONTENT) { click_link "Create an account" }
  end

  def visit_settings
    visit root_path
    within(Selectors::TITLEBAR) do
      find(Selectors::USER_MENU).click
      click_link "Settings"
    end
  end

  def signup_form(name, email, password, password_confirmation)
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password_confirmation
    click_button "Sign up"
  end
end
