require 'rails_helper'

describe 'User Favorites', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  
  before do
    login_as(user, scope: :user)
    visit user_path(user)
  end

  context 'when user has topics' do

    before do
      visit topics_path
      10.times do
        create_topic
      end
      visit user_path(user)
    end

    it 'displays topic#count' do
      within('#topics') do
        expect(page).to have_content user.likes.count
      end
    end

    it 'displays first 5 topics' do
      expect(page).to have_selector('.ind-topic', count: 5)
    end

    it 'displays pagination links' do
      within('#topic-pagination') do
        expect(page).to have_selector '.pagination'
      end
    end
  end

  context 'when removing topics' do

    before do
      topic
      visit user_path(user)
    end

    it 'displays link to delete topic' do
      within('.ind-topic') do
        expect(page).to have_link 'delete_topic'
      end
    end

    it 'removes user topic' do
       within('.ind-topic') do
        click_link 'delete_topic'
      end
      expect(page).not_to have_content topic.title
    end

    it 'redirects to user-profile' do
      within('.ind-topic') do
        click_link 'delete_topic'
      end
      expect(current_path).to eq user_path(user)
    end
  end
end

def create_topic
  fill_in 'title', with: topic.title
  click_button 'create_topic'
end