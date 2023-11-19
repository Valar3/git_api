# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'it checks if the blacklist feature is working' do
  let!(:user) { create(:user) }

  before do
    driven_by(:selenium_chrome_headless)
    visit login_path
    click_button 'Login with GitHub'
    stub_request(:get, 'https://api.github.com/user/repos')
      .to_return(
        status: 200,
        body: [
          { 'name' => 'Repo1', 'owner' => { 'login' => 'user1' }, 'updated_at' => '2023-11-07' }
        ].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
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
