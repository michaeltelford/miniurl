require 'urls_helper'

class Url < ActiveRecord::Base
  include UrlsHelper
  
  validates :internal, presence: true, length: { is: 8 }, uniqueness: { case_sensitive: true }
  validates :external, presence: true, uniqueness: { case_sensitive: false }, exclusion: {
    in: %w(http:// https://), message: "%{value} is not a valid external url"
  }
  
  after_initialize :after_initialize_callback
  before_save :before_save_callback
  
  def external_empty?
    external.empty? or external == "http://" or external == "https://"
  end
  
  def full_internal
    build_url(internal)
  end
  
private
  
  # We make sure that on initialization the object has unique internal url/ID. 
  def after_initialize_callback
    # The 'self.' bits below are needed, do not remove.
    self.internal = unique_id unless self.internal?
  end
  
  # After the external has been validated we prefix the protocol if needed 
  # before saving the record to the DB. 
  def before_save_callback
    prefix_protocol(external)
  end
end
