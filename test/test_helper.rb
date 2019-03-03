ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as_jane
    post login_url, params: { session: { email: "jane.doe@example.com",
                                         password: "foo" } }
  end

  def logout
    delete logout_url
  end
end
