class UsersController < ApplicationController
  def dashboard
    return redirect_to login_path, alert: 'Please log in to view your dashboard.' unless current_user

    github_service = GithubService.new(current_user.github_access_token)
    all_repositories = github_service.user_repositories_with_star_count
    @repo_names = all_repositories.map { |repo| repo['name'] }

    @repositories = filter_and_sort_repositories(all_repositories, params[:query])
  end

  private

  def filter_and_sort_repositories(repositories, query)
    filtered_repos = if query.present?
                       repositories.select { |repo| repo['name'].downcase.include?(query.downcase) }
                     else
                       repositories
                     end

    filtered_repos.sort_by { |repo| DateTime.parse(repo['updated_at'] || '') }.reverse
  end
end
