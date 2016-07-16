require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_template :index
    refute_nil assigns["urls"]
  end
  
  test "should get show" do
    get :show, id: 1
    assert_response :success
    assert_template :show
    refute_nil assigns["url"]
  end
  
  test "should get new" do
    get :new
    assert_response :success
    assert_template :new
  end
  
  test "should create mini url" do
    # External with protocol prefixed.
    external = "https://duckduckgo.com"
    post_create_url(external)
    assert_equal 1, Url.where(external: external).count
    
    # External without protocol prefixed.
    external = "duckduckgo.com"
    post_create_url(external)
    assert_equal 1, Url.where(external: "http://#{external}").count
  end
  
  test "shouldn't create mini url because it already exists" do
    external = urls(:google).external
    post_create_url(external)
    assert_equal 1, Url.where(external: external).count
  end
  
  test "should redirect to url" do
    url = urls(:google)
    get :redirect, { internal_url: url.internal.strip }
    assert_response :redirect
    assert_redirected_to url.external.strip, { status: "found" }
  end
  
  test "shouldn't redirect to url because internal doesn't exist" do
    get :redirect, { internal_url: "not_in_db" }
    assert_response :redirect
    assert_equal "The Mini Url wasn't recognized.", flash[:notice]
    assert_redirected_to new_url_path
  end
  
private
  
  def post_create_url(external)
    post :create, { url: { external: external.strip } }
    assert_response :redirect
    assert_redirected_to url_path(assigns["url"])
  end
end
