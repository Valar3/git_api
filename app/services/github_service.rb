class GithubService
  include HTTParty
  base_uri 'https://api.github.com'
  headers 'Accept' => 'application/json'

  def initialize(access_token)
    @access_token = access_token
  end

  def user_repositories
    begin
      response = self.class.get('/user/repos', headers: { 'Authorization' => "token #{@access_token}" })
      JSON.parse(response.body)
    rescue StandardError => e
      Rails.logger.error("GitHub API Error: #{e.message}")
      []
    end
  end
  
  def user_repositories_with_star_count
    repositories = user_repositories

    repositories.each do |repo|
      star_count = fetch_star_count(repo['owner']['login'], repo['name'])
      repo['star_count'] = star_count
    end

    repositories
  end

  private

  def fetch_star_count(owner, repo_name)
    response = self.class.get("/repos/#{owner}/#{repo_name}")
    json_response = JSON.parse(response.body)
    json_response['stargazers_count']
  end
end
