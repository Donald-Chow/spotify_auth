require "uri"
require "net/http"

module Spotify
  class AccessToken
    def initialize(user, code)
      # can be moved to Spotify::Base
      @base_url = 'https://accounts.spotify.com'
      @base64_credentials = Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")
      # required for this service
      @endpoint = '/api/token'
      @grant_type = 'authorization_code'
      @redirect_uri = 'http://localhost:3000/spotify/authorize' # callback controller
      @code = code
      @user = user
    end

    def call
      url = URI(@base_url + @endpoint)
      body = "code=#{@code}"
      body += "&redirect_uri=#{@redirect_uri}"
      body += "&grant_type=#{@grant_type}"

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Basic #{@base64_credentials}"
      request["Content-Type"] = "application/x-www-form-urlencoded"
      request.body = body

      response = https.request(request)
      json_response =  JSON.parse(response.read_body)

      if json_response['access_token'].present?
        @user.spotify_access_token = json_response['access_token']
        @user.spotify_refesh_token = json_response['refresh_token']
        @user.save
        'ok'
      else
        'error'
      end
    end
  end
end
