module OmniAuth
  module Strategies
    class Namely < OmniAuth::Strategies::OAuth2
      option :name, 'namely'
      option :client_options,
             {
                 :authorize_url => '/api/v1/oauth2/authorize',
                 :site => 'https://nicholas-eng-homework.namely.com',
                 :token_url => '/api/v1/oauth2/token'

             }

      uid do
        profile["profiles"][0]["id"]
      end

      info do
        {
            name: profile["profiles"][0]["full_name"]

        }
      end


      def profile
        @profile ||= access_token.get('/api/v1/profiles/me.json').parsed
      end

      def employees_first
        @employees ||= access_token.get('api/v1/profiles.json?sort=first_name').parsed
      end
    end
  end
end
