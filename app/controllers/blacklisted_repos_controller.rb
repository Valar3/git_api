# frozen_string_literal: true

class BlacklistedReposController < ApplicationController
  def index
    blacklisted_repos = current_user.blacklisted_repos
    render :index, locals: { blacklisted_repos:, current_user: }
  end

  def create
    current_user.blacklisted_repos.create(blacklisted_repo_name: params[:blacklisted_repo_name])
    flash[:notice] = 'Repository added to blacklist'
    redirect_to dashboard_path
  end

  def destroy
    current_user.blacklisted_repos.find_by(blacklisted_repo_name: params[:blacklisted_repo_name])&.destroy
    flash[:notice] = 'Repository removed from blacklist'
    redirect_to blacklisted_repos_path
  end
end
