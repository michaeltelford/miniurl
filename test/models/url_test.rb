require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  def setup
    @internal = "fah847rd"
    @full_internal = "http://localhost:3000/#{@internal}"
    @external = "http://www.google.co.uk"
  end
  
  test "initialize sets internal" do
    url = Url.new({ external: @external })
    assert_equal @external, url.external
    assert_not_nil(url.internal)
    assert(url.internal.length == 8)
  end
  
  test "initialize doesn't set internal" do
    url = Url.new({ 
      internal: @internal, 
      external: @external 
    })
    assert_equal @internal, url.internal
  end
  
  test "external_empty?" do
    url = Url.new({
      internal: @internal,
      external: ""
    })
    assert url.external_empty?
    
    url.external = "http://"
    assert url.external_empty?
    
    url.external = "https://"
    assert url.external_empty?
    
    url.external = "http://www.google.co.uk"
    refute url.external_empty?
  end
  
  test "full_internal" do
    url = Url.new({ 
      internal: @internal, 
      external: @external 
    })
    assert_equal @full_internal, url.full_internal
  end
  
  test "external with protocol is invalid" do
    # http:// external is invalid?
    url = Url.new({ 
      internal: @internal, 
      external: "http://"
    })
    refute url.valid?

    # https:// external is invalid?    
    url = Url.new({ 
      internal: @internal, 
      external: "https://"
    })
    refute url.valid?
  end
  
  test "save prepends protocol to external url" do
    url = Url.new({ 
      internal: @internal, 
      external: "www.google.co.uk"
    })
    assert url.save
    assert_equal @external, url.external
  end
  
  test "save returns false with empty external url" do
    url = Url.new({ 
      internal: @internal, 
      external: ""
    })
    refute url.save
  end
  
  test "save! fails with empty external url" do
    url = Url.new({ 
      internal: @internal, 
      external: ""
    })
    begin
      url.save!
      flunk
    rescue
      pass
    end
  end
end
