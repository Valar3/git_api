class BlacklistedReposController < ApplicationController
  def create
    current_user.blacklisted_repos.create(blacklisted_repo_name: params[:blacklisted_repo_name])
    redirect_to dashboard_path
  end

  def destroy
    current_user.blacklisted_repos.find_by(blacklisted_repo_name: params[:blacklisted_repo_name])&.destroy
    redirect_to blacklisted_repos_path
  end

  def index
    @blacklisted_repos = current_user.blacklisted_repos
  end
end
