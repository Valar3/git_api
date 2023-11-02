class UsersController < ApplicationController
  def dashboard
    return redirect_to login_path, alert: 'Please log in to view your dashboard.' unless current_user

    repository_service = RepositoryService.new(current_user)
    @repositories = repository_service.fetch_repositories(params[:query])
    @repo_names = @repositories.map { |repo| repo['name'] }
  end
end
