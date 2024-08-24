module Spotify
  class Base
    def initialize
      @base_url = 'https://accounts.spotify.com'
      @base64_credentials = Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")
    end
  end
end
