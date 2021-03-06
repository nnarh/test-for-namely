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
    client = OAuth2::Client.new(ENV['NAMELY_KEY'], ENV['NAMELY_SECRET'],
                                :site => 'https://nicholas-eng-homework.namely.com/oauth2/callback', :authorize_url => "/api/v1/oauth2/authorize", :token_url => "/api/v1/oauth2/token")

    client.auth_code.authorize_url(:redirect_uri => 'https://shielded-brook-62723.herokuapp.com/oauth2/callback')
    token = client.auth_code.get_token(session['code'], :redirect_uri => 'https://shielded-brook-62723.herokuapp.com/auth/namely/callback',
                                       :headers => {'Accept' => 'application/json'})
  end
end
