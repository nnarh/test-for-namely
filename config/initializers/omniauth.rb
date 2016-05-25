require File.expand_path('lib/omniauth/strategies/namely', Rails.root)

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :namely, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret

  OmniAuth.config.on_failure = Proc.new do |env|
    SessionsController.action(:auth_failure).call(env)
  end
end