require 'test_helper'

class WelcomeRoutesTest < ActionController::TestCase
  test "should route to welcome index" do
    assert_routing '/welcome/index', { controller: "welcome", action: "index" }
  end
end
