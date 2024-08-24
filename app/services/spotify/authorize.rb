module Spotify
  class Authorize < Spotify::Base
    def initialize
      @endpoint = '/authorize'
      @redirect_uri = 'http://localhost:3000/spotify/authorize'
      @scope = 'user-top-read' # space separated value
      super()
    end

    def call
      url = @base_url + @endpoint
      url += '?'
      url += 'response_type=code'
      url += "&redirect_uri=#{@redirect_uri}"
      url += "&scope=#{@scope}"
      url += "&client_id=#{ENV['SPOTIFY_CLIENT_ID']}"

      @spotify_url = 'https://accounts.spotify.com/authorize'
      @spotify_url += '?'
      @spotify_url += 'response_type=code'
      @spotify_url += "&redirect_uri=#{@redirect_uri}"
      @spotify_url += "&scope=#{@scope}"
      @spotify_url += "&client_id=#{ENV['SPOTIFY_CLIENT_ID']}"

      puts url
    end
  end
end
