require 'test_helper'

class UrlsHelperTest < ActionView::TestCase
  include UrlsHelper
 
  test "should return a unique id" do
    id = unique_id
    refute_nil id
    assert_equal 8, id.length
    assert Url.where(internal: id).empty?
  end
  
  test "should prefix protocol" do
    url = "www.google.co.uk"
    prefix_protocol url
    assert_equal "http://www.google.co.uk", url
  end
  
  test "should build and return full url" do
    full_url = build_url "syfd34kv"
    assert_equal "http://localhost:3000/syfd34kv", full_url
  end
end
