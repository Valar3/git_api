# frozen_string_literal: true

class CreateBlacklistedRepos < ActiveRecord::Migration[7.0]
  def change
    create_table :blacklisted_repos do |t|
      t.references :user, foreign_key: true
      t.string :blacklisted_repo_name
      t.timestamps
    end
  end
end
