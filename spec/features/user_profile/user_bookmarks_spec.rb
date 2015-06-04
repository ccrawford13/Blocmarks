require 'rails_helper'

describe 'User Bookmarks', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  before do
    login_as(user, scope: :user)
    visit user_path(user)
  end

  context 'when user has bookmarks' do

    before do
      visit topic_path(topic)
      10.times do
        create_bookmark
      end
      visit user_path(user)
    end

    it 'displays bookmarks#count' do
      within('#user-bookmarks') do
        expect(page).to have_content user.bookmarks.count
      end
    end

    it 'displays first 5 bookmarks' do
      expect(page).to have_selector('.bookmark', count: 5)
    end

    it 'displays pagination links' do
      within('#bookmark-pagination') do
        expect(page).to have_selector '.pagination'
      end
    end
  end

 context 'when removing bookmarks' do

    before do
      bookmark
      visit user_path(user)
    end

    it 'displays link to delete bookmark' do
      within('.bookmark') do
        expect(page).to have_link 'delete_bookmark'
      end
    end

    it 'removes user bookmark' do
       within('.bookmark') do
        click_link 'delete_bookmark'
      end
      expect(page).not_to have_content bookmark.description
    end

    it 'redirects to user-profile' do
      within('.bookmark') do
        click_link 'delete_bookmark'
      end
      expect(current_path).to eq user_path(user)
    end
  end
end

def create_bookmark
  fill_in 'description', with: bookmark.description
  fill_in 'url', with: bookmark.url
  click_button 'create_bookmark'
end

