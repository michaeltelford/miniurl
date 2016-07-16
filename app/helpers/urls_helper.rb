require 'securerandom'

# Helper class for common Url behaviour mainly used by controllers and models.
module UrlsHelper
  # TODO: Retrieve the url segments instead of hard-coding below.
  PROTO = "http".freeze
  HOST = "localhost".freeze
  PORT = 3000.freeze
  
  def unique_id
    # TODO: Add a unique index to internal and refactor below.
    id = nil
    loop do
      id = SecureRandom.uuid.split("-").first
      break if Url.where(internal: id).empty?
    end
    id
  end
  
  def prefix_protocol(url)
    url.replace("#{PROTO}://#{url}") unless url.start_with?(PROTO)
    url
  end
  
  def build_url(internal)
    "#{PROTO}://#{HOST}:#{PORT}/#{internal}"
  end
end
