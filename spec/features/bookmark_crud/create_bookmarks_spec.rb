require 'rails_helper'

describe "Creation of bookmarks", js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  before do
    login_as(user, scope: :user)
    visit topic_path(topic)
  end

  it "displays form to create url" do
    expect(page).to have_button "create_bookmark"
  end

  context "when user is present" do

    before do
      fill_in "description", with: bookmark.description
      fill_in "url", with: bookmark.url
      click_button "create_bookmark"
      visit user_path(user)
    end

    it "adds created bookmark to user#show" do
      expect(page).to have_content bookmark.description
    end
  end

  context "when no user is present" do

    it "prompts user to sign-up" do
    end
  end

  context "with valid url" do
    
    it "displays newly created bookmark" do
    end

  end

  context "with invalid url" do
  end
end