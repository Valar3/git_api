class RepositoryService
  def self.call(user, github_gateway, query = nil)
    new(user, github_gateway).send(:fetch_repositories, query)
  end

  private

  attr_reader :user, :github

  def initialize(user, github_gateway)
    @user = user
    @github = github_gateway
  end

  def fetch_repositories(query)
    all_repositories = @github.user_repositories

    blacklisted_repo_names = user.blacklisted_repos.pluck(:blacklisted_repo_name)
    filtered_repositories = all_repositories.reject do |repo|
      blacklisted_repo_names.include?(repo['name'])
    end

    if query.present?
      query_downcase = query.downcase
      filtered_repositories.select! { |repo| repo['name'].downcase.include?(query_downcase) }
    end

    assign_star_counts(filtered_repositories)
  end

  def assign_star_counts(repositories)
    repositories.map do |repo|
      repo.merge('star_count' => @github.fetch_star_count(repo['owner']['login'], repo['name']))
    end
  end
end
