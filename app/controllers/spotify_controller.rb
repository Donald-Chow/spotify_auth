class SpotifyController < ApplicationController
  def authorize
    code = params['code']
    if code.present?
      Spotify::AccessToken.new(current_user, code).call
      redirect_to  root_path, flash: { success: 'Authorized with Spotify' }
    else
      redirect_to root_path, flash: { error: 'Failed to authorize with Spotify' }
    end
  end

  def token
    raise
  end
end
