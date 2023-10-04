class GithubService
  include HTTParty
  base_uri 'https://api.github.com'
  headers 'Accept' => 'application/json'

  def initialize(access_token)
    @access_token = access_token
  end

  def user_repositories
    response = self.class.get('/user/repos', headers: { 'Authorization' => "token #{@access_token}" })
    JSON.parse(response.body)
  end
end
