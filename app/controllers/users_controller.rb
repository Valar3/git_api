# frozen_string_literal: true

class UsersController < ApplicationController
  def dashboard
    repository_service = RepositoryService.new(current_user)
    repositories = repository_service.fetch_repositories(params[:query])
    repo_names = repositories.pluck('name')
    render 'dashboard', locals: { repo_names:, repositories:  }
  end
end
