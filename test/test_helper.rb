ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require_relative 'support/const'
require_relative 'support/selectors'
require 'rails/test_help'

class ActiveSupport::TestCase
  # NOTE This option still have some problems with emails, enable it when ready to use.
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Configure Capybara to listen same port as configured at env file to Devise
  Capybara.configure do |config|
    config.server_port = 3001
  end

  # Add more helper methods to be used by all tests here...
  include Warden::Test::Helpers # for authentication
  include AbstractController::Translation # for use t() helper

  def last_email_link(text)
    email = ActionMailer::Base.deliveries.last
    html = Nokogiri::HTML(email.body.to_s)

    html.at("a:contains('#{text}')")['href']
  end
end
