require 'rails_helper'

describe "Creation of bookmarks", js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  before do
    login_as(user, scope: :user)
    visit topic_path(topic)
  end

  context "when user is present" do

    it "displays form to create url" do
      expect(page).to have_button "create_bookmark"
    end
  end

  context "when user who created record is present" do

    before do
      fill_in "description", with: bookmark.description
      fill_in "url", with: bookmark.url
      click_button "create_bookmark"
      visit user_path(user)
    end

    it "adds created bookmark to user's profile" do
      expect(page).to have_content bookmark.description
    end
  end

  context "when no user is present" do
    # Sign out user then navigate back to topic#show
    before do
      sign_out_user
      visit topic_path(topic)
    end

    it "hides form to create bookmarks" do
      expect(page).not_to have_button "create_bookmark"
    end
  end

  context "valid bookmark" do

    before do
      fill_in "description", with: bookmark.description
      fill_in "url", with: bookmark.url
      click_button "create_bookmark"
    end
    
    it "displays newly created bookmark" do
      expect(page).to have_content bookmark.description
    end
  end

  context "invalid bookmark" do

    context "when description is invalid" do

      before do
        fill_in "url", with: bookmark.url
      end

      it "displays error when description is blank" do
        click_button "create_bookmark"
        expect(page).to have_content "Error creating Bookmark. [\"Description can't be blank\""
      end

      it "displays error when description is too short" do
        # Description must be 3 or more characters
        fill_in "description", with: "Hi"
        click_button "create_bookmark"
        expect(page).to have_content "Error creating Bookmark. [\"Description is too short"
      end

      it "displays error when description is too long" do
        # Description must be less than 30 characters
        fill_in "description", with: "This is a super long description over 30 Characters"
        click_button "create_bookmark"
        expect(page).to have_content "Error creating Bookmark. [\"Description is too long"
      end
    end

    context "when url is invalid" do

      before do
        fill_in "description", with: bookmark.description
      end

      it "displays error when url is blank" do
        click_button "create_bookmark"
        expect(page).to have_content "Error creating Bookmark. [\"Url can't be blank"
      end

      it "displays error when url is invalid" do
        # Url requires http:// to be valid
        fill_in "url", with: "google.com"
        click_button "create_bookmark"
        expect(page).to have_content "Error creating Bookmark. [\"Url is invalid"
      end
    end
  end
end

def sign_out_user
  click_link "sign_out"
  visit topic_path(topic)
end
