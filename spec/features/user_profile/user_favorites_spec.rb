require 'rails_helper'

describe 'User Favorites', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic) }
  let!(:like) { create(:like, bookmark: bookmark, user: user) }

  before do
    login_as(user, scope: :user)
    visit user_path(user)
  end

  context 'when user has favorites' do

    before do
      visit topic_path(topic)
      10.times do
        create_bookmark_and_like
      end
      visit user_path(user)
    end

    it 'displays like#count' do
      within('#favorite-bookmarks') do
        expect(page).to have_content user.likes.count
      end
    end

    it 'displays first 5 favorites' do
      expect(page).to have_selector('.ind-favorite', count: 5)
    end

    it 'displays pagination links' do
      within('#favorite-bookmarks')do
        expect(page).to have_selector '.pagination'
      end
    end
  end

  context 'when removing favorites' do

    before do
      click_link 'remove_favorite'
    end

    it 'removes user favorite' do
      expect(page).not_to have_content bookmark.description
    end

    it 'redirects to user-profile' do
      expect(current_path).to eq user_path(user)
    end
  end
end

def create_bookmark_and_like
  fill_in 'description', with: bookmark.description
  fill_in 'url', with: bookmark.url
  click_button 'create_bookmark'
  click_link 'favorite_bookmark'
end