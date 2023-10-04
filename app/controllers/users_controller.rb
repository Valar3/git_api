class UsersController < ApplicationController
  def dashboard
    if current_user
      github_service = GithubService.new(current_user.github_access_token)
      @repositories = github_service.user_repositories_with_star_count
      @repositories = @repositories.sort_by { |repo| repo['updated_at'] }.reverse
    else
      redirect_to login_path, alert: 'Please log in to view your dashboard.'
    end
  end
end

