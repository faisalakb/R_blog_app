require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 5, author: user) }

  scenario 'displays user information and interactions' do
    visit user_path(user)

    expect(page).to have_selector('.userImg', visible: false, count: 1)
    expect(page).to have_css('.userName', text: user.name)
    expect(page).to have_css('.Upostcount', text: "Number of Posts: #{user.posts.count}")
    expect(page).to have_css('.bioText', text: user.bio)

    expect(page).to have_button('See all posts', visible: true)

    click_button('See all posts')
    expect(page).to have_current_path(user_posts_path(user))
  end

  scenario 'redirects to post show page when clicking a post' do
    visit users_path

    if page.has_css?('.recPost')
      first('.recPost').click

      expect(page).to have_current_path(user_post_path(user, user.recent_posts.first))
    else
      puts 'No recent posts found.'
    end
  end
end
