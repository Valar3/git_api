class GithubService
  include HTTParty
  base_uri 'https://api.github.com'
  headers 'Accept' => 'application/json'

  def initialize(access_token)
    @access_token = access_token
  end

  def user_repositories
    fetch_from_github('/user/repos')
  end

  def user_repositories_with_star_count
    user_repositories.map do |repo|
      repo.merge('star_count'=> fetch_star_count(repo['owner']['login'], repo['name']))
    end
  end

  def search_repositories(query)
    fetch_from_github('/search/repositories', query: { q: query })["items"]
  end

  private

  def fetch_from_github(endpoint, options = {})
    options[:headers] = { 'Authorization' => "token #{@access_token}" }
    response = self.class.get(endpoint, options)

    if response.success?
      JSON.parse(response.body)
    else
      handle_error(response)
      []
    end
  end

  def fetch_star_count(owner, repo_name)
    response = self.class.get("/repos/#{owner}/#{repo_name}")
    response.success? ? JSON.parse(response.body)['stargazers_count'] : nil
  end

  def handle_error(response)
    error_message = "GitHub API Error: #{response.body}"
    Rails.logger.error(error_message)
    error_message
  end
end
