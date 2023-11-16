# frozen_string_literal: true

require 'http'

class GithubGateway
  BASE_URI = 'https://api.github.com'

  def initialize(access_token)
    @access_token = access_token
  end

  def user_repositories
    fetch_from_github('/user/repos')
  end

  def user_repositories_with_star_count
    user_repositories.map do |repo|
      repo.merge('star_count' => fetch_star_count(repo['owner']['login'], repo['name']))
    end
  end

  def search_repositories(query)
    fetch_from_github('/search/repositories', query: { q: query }).parse['items']
  end

  private

  def fetch_from_github(endpoint, options = {})
    response = HTTP.headers(accept: 'application/json', authorization: "token #{@access_token}")
                   .get(BASE_URI + endpoint, params: options[:query])

    if response.status.success?
      response.parse
    else
      handle_error(response)
      []
    end
  end

  def fetch_star_count(owner, repo_name)
    response = HTTP.headers(accept: 'application/json', authorization: "token #{@access_token}")
                   .get("#{BASE_URI}/repos/#{owner}/#{repo_name}")

    response.status.success? ? response.parse['stargazers_count'] : nil
  end

  def handle_error(response)
    error_message = "GitHub API Error: #{response.body}"
    Rails.logger.error(error_message)
  end
end
