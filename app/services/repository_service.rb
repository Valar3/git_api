# frozen_string_literal: true

class RepositoryService
  attr_reader :user

  def initialize(user)
    @user = user
    @github = GithubGateway.new(user.github_access_token)
  end

  def fetch_repositories(query = nil)
    all_repositories = @github.user_repositories_with_star_count
    blacklisted_repo_names = user.blacklisted_repos.pluck(:blacklisted_repo_name)

    filtered_repositories = all_repositories.reject do |repo|
      blacklisted_repo_names.include?(repo['name'])
    end

    if query.present?
      query_downcase = query.downcase
      filtered_repositories.select! { |repo| repo['name'].downcase.include?(query_downcase) }
    end

    filtered_repositories.sort_by { |repo| DateTime.parse(repo['updated_at']) }.reverse
  end
end
