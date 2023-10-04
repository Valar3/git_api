Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'bb1719151f252f82b00f', 'be2b5572c9d1d76cc86cb2428582143e0dc7717b'
end
