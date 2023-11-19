# frozen_string_literal: true

class UsersController < ApplicationController
  def dashboard
    github_gateway = GithubGateway.new(current_user.github_access_token)
    repositories = RepositoryService.call(current_user, github_gateway, params[:query])
    repo_names = repositories.pluck('name')
    render 'dashboard', locals: { repo_names:, repositories: }
  end
end
