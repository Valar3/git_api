# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'it checks if the blacklist feature is working' do
  let!(:user) { create(:user) }

  before do
    driven_by(:selenium_chrome_headless)
    visit login_path
    click_button 'Login with GitHub'

    mock_repo = [
      { 'name' => 'Repo1', 'owner' => { 'login' => 'user1' }, 'updated_at' => '2023-11-07' }
    ]

    github_service = GithubService.new(user.github_access_token)
    allow(GithubService).to receive(:new).and_return(github_service)
    allow(github_service).to receive(:fetch_from_github).with('/user/repos').and_return(mock_repo)
  end

  it 'checks if the repo is present' do
    visit dashboard_path
    expect(page).to have_text 'Repo1'
  end

  it 'checks if the blacklist button is working' do
    visit dashboard_path
    click_button 'Blacklist'
    click_button 'Black List'
    expect(page).to have_text 'Repo1'
  end

  it 'checks is the deletion from blacklist is working' do
    visit dashboard_path
    click_button 'Blacklist'
    visit blacklisted_repos_path
    click_button 'Remove from Blacklist'
    click_button 'Back to Dashboard'
    expect(page).to have_text 'Repo1'
  end
end
