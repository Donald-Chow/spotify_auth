module Spotify
  class RefreshToken
    def initialize(user)
      @endpoint = '/api/token'
      @user = user
      @grant_type = 'refresh_token'
      @refresh_token = @user.spotify_refesh_token
      super()
    end

    def call
      body = {
        grant_type: @grant_type,
        refresh_token: @refresh_token
      }

      response = RestClient.get(
        url,
        body: body,
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'Authorization': "Basic #{@base64_credentials}"
        }
      )

      if response.ok?
        body = JSON.parse(reponse.body)
        @user.access_token = body.access_token
        @user.refresh_token = body.refresh_token if body.refresh_token.exisit?
        @user.save
      else
        Spotify::Authorize.new.call
      end
    end
  end
end
