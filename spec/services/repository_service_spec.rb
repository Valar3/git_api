# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositoryService, type: :service do
  let(:user) { create(:user) }
  let(:service) { described_class.new(user) }

  before do
    mock_repos = [
      { 'name' => 'Repo1', 'owner' => { 'login' => 'user1' }, 'updated_at' => '2023-11-07' },
      { 'name' => 'Repo2', 'owner' => { 'login' => 'user2' }, 'updated_at' => '2023-11-08' }
    ]
    github_service = GithubService.new(user.github_access_token)
    allow(GithubService).to receive(:new).and_return(github_service)
    allow(github_service).to receive(:fetch_from_github).with('/user/repos').and_return(mock_repos)
  end

  it 'checks if the repos are displayed in the correct order' do
    repo_sorted = service.fetch_repositories
    expect(repo_sorted.first['name']).to eq('Repo2')
  end

  it 'check if the search feature works' do
    repo_search = service.fetch_repositories('repo2')
    expect(repo_search.length).to eq(1)
    expect(repo_search.first['name']).to eq('Repo2')
  end
end
