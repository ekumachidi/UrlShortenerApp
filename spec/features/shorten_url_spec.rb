require 'rails_helper'

RSpec.feature 'ShortenUrl', type: :feature do
  scenario 'User creates a shortened URL with valid parameters' do
    visit '/'

    fill_in 'short_url[original_url]', with: 'http://github.com'
    click_button 'Shorten'

    expect(page).to have_text('Your link was shortened to:')
  end

  scenario 'User creates a shortened URL with invalid parameters displays a error message' do
    visit '/'

    fill_in 'short_url[original_url]', with: 'github.com'
    click_button 'Shorten'

    expect(page).to have_text('This URL could not be shortened due to')
  end

  scenario 'User sees a list of most visited URLs' do
    visit '/'

    click_link 'See the most visited pages'

    expect(page).to have_text('Most Viewed links')
  end
end
