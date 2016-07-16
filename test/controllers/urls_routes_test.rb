require 'test_helper'

class UrlsRoutesTest < ActionController::TestCase
  test "should route to index urls" do
    assert_routing '/urls', { controller: "urls", action: "index" }
  end
  
  test "should route to show url" do
    assert_routing '/urls/1', { controller: "urls", action: "show", id: "1" }
  end
  
  test "should route to new url" do
    assert_routing '/urls/new', { controller: "urls", action: "new" }
  end
 
  test "should route to create url" do
    assert_routing(
      { method: 'post', path: '/urls' }, 
      { controller: "urls", action: "create" }
    )
  end
  
  test "should route to redirect url" do
    assert_routing '/syfd34kv', { 
      controller: "urls", action: "redirect", internal_url: "syfd34kv"
    }
  end
end
