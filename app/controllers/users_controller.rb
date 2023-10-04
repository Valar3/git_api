class UsersController < ApplicationController
  def dashboard
    @user = current_user
    github_service = GithubService.new(@user.github_access_token)
    @repositories = github_service.user_repositories
  end
end
