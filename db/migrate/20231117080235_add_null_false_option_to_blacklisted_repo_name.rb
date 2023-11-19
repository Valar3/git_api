class AddNullFalseOptionToBlacklistedRepoName < ActiveRecord::Migration[7.0]
  def change
    change_column :blacklisted_repos, :blacklisted_repo_name, :string, null: false
  end
end
