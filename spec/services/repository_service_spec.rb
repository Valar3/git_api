# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositoryService, type: :service do
  let(:user) { create(:user) }
  let(:github_gateway) { GithubGateway.new(user.github_access_token) }

  before do
    stub_request(:get, 'https://api.github.com/user/repos')
      .to_return(
        status: 200,
        body: [
          { 'name' => 'Repo1', 'owner' => { 'login' => 'user1' }, 'updated_at' => '2023-11-07' },
          { 'name' => 'Repo2', 'owner' => { 'login' => 'user2' }, 'updated_at' => '2023-11-08' }
        ].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  it 'checks if the repos are displayed in the correct order' do
    repo_sorted = described_class.call(user, github_gateway)
    expect(repo_sorted.first['name']).to eq('Repo2')
  end

  it 'check if the search feature works' do
    repo_search = described_class.call(user, github_gateway, 'Repo2')
    expect(repo_search.length).to eq(1)
    expect(repo_search.first['name']).to eq('Repo2')
  end
end
