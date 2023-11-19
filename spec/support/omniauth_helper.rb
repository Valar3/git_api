OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  provider: 'github',
  uid: '123545',
  info: {
    email: 'testuser@example.com',
    name: 'Test User',
    nickname: 'testuser'
  },
  credentials: {
    token: 'mock_token',
    secret: 'mock_secret'
  }
})
