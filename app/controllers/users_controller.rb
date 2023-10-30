class UsersController < ApplicationController
  def dashboard
    return redirect_to login_path, alert: 'Please log in to view your dashboard.' unless current_user

    github_service = GithubService.new(current_user.github_access_token)
    all_repositories = github_service.user_repositories_with_star_count

    @repo_names = all_repositories.map { |repo| repo['name'] }

    @repositories = if params[:query].present?
                      query_downcase = params[:query].downcase
                      all_repositories.select do |repo|
                        repo_name_words = repo['name'].downcase.split(/ |-|_/)
                        repo_name_words.include?(query_downcase)
                      end
                    else
                      all_repositories
                    end

    @repositories.sort_by! { |repo| repo['updated_at'] }.reverse!
  end
end
