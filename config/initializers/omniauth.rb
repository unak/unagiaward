Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.getenv('TWITTER_API_KEY'), Rails.application.getenv('TWITTER_API_SECRET')
  provider :github, Rails.application.getenv('GITHUB_API_KEY'), Rails.application.getenv('GITHUB_API_SECRET')
end
