# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'it check if the sign in user is possible' do
  before do
    driven_by(:selenium_chrome_headless)
    visit login_path
    click_button 'Login with GitHub'
  end

  it 'checks the message' do
    visit dashboard_path
    expect(page).to have_text 'No matches found'
  end

  it 'check if the Black list button is present' do
    visit dashboard_path
    expect(page).to have_button 'Black List'
  end
end
