class ApplicationController < ActionController::Base
  include Clearance::Controller

  protected

  def authenticate_via_token
    return unless api_token
    user = User.find_by(remember_token:api_token)
    sign_in user if user
    cookies.delete(:remember_token) # so non-browser clients don't act like browsers and persist sessions in cookies
  end

private

  def api_token
    pattern = /^Bearer /
    header  = request.headers["authorization"]
    return header
  end

end
