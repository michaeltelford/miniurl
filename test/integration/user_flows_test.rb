require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "ceate and use mini url" do
    # Create the mini url.
    external = "www.yahoo.co.uk"
    post_via_redirect(urls_path, { url: { external: external.strip } })
    assert_response :success
    assert assigns["url"]
    
    # Use the mini url.
    internal = assigns["url"].internal
    get_via_redirect('/:internal_url', internal_url: internal)
    assert_response :success
    # new_url_path is the url before the redirect to the external url.
    # We assert it because the external url is outside of Rails.
    assert_equal new_url_path, path
  end
end
