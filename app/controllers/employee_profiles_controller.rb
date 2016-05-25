class EmployeeProfilesController < ApplicationController
  def index
  #use https://github.com/intridea/oauth2
    unsorted_profiles = client_authorization.get('/api/v1/profiles.json')
    @employees = JSON.parse(unsorted_profiles.body)

    sorted_profiles = client_authorization.get('/api/v1/profiles.json?sort=first_name')
    @sorted_employees =  JSON.parse(sorted_profiles.body)
  end

  private

  def client_authorization
    client = OAuth2::Client.new(Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret,
                                :site => Rails.application.secrets.domain_name, :authorize_url => "/api/v1/oauth2/authorize", :token_url => "/api/v1/oauth2/token")
    client.auth_code.authorize_url(:redirect_uri => 'https://shielded-brook-62723.herokuapp.com/oauth2/callback')
    token = client.auth_code.get_token(session['code'], :redirect_uri => 'https://shielded-brook-62723.herokuapp.com/auth/namely/callback',
                                       :headers => {'Accept' => 'application/json'})
  end
end
