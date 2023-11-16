# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.application.credentials.github, Rails.application.credentials.github_secret
end
