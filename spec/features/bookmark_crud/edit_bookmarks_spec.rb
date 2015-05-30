require 'rails_helper'

describe "Updating bookmarks", js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  before do
    login_as(user, scope: :user)
    visit topic_path(topic)
    fill_in "description", with: bookmark.description
    fill_in "url", with: bookmark.url
    click_button "create_bookmark"
  end

  context "with correct permissions" do

    it "displays link to update bookmark" do
      expect(page).to have_link "edit_bookmark"
    end
  end

  context "with incorrect permissions" do

    before do
      sign_out_user
      visit topic_path(topic)
    end
    
    it "hides link to update bookmark" do
      expect(page).not_to have_link "edit_bookmark"
    end
  end

  context "when link is clicked" do

    before do
      click_link "edit_bookmark"
    end

    it "displays form to update bookmark" do
      expect(page).to have_button "save_bookmark"
    end
  end

  context "valid update" do

    before do
      click_link "edit_bookmark"
      within(".edit_bookmark") do
        fill_in "description", with: "Google Images"
        fill_in "url", with: "http://google.com/images"
        click_button "save_bookmark"
      end
    end

    it "updates bookmark" do
      expect(page).to have_content "Google Images"
    end
  end

  context "invalid update" do

    before do
      click_link "edit_bookmark"
    end

    context "when description is invalid" do

      before do
        within(".edit_bookmark") do
          fill_in "url", with: bookmark.url
        end
      end

      it "displays error when description is blank" do
        within(".edit_bookmark") do
          # Description is currently filled in - must be replaced with blank string
          fill_in "description", with: ""
          click_button "save_bookmark"
        end
        expect(page).to have_content "Error updating Bookmark. [\"Description can't be blank\""
      end

      it "displays error when description is too short" do
        within(".edit_bookmark") do
          # Description must be 3 or more characters
          fill_in "description", with: "Hi"
          click_button "save_bookmark"
        end
        expect(page).to have_content "Error updating Bookmark. [\"Description is too short"
      end

      it "displays error when description is too long" do
        within(".edit_bookmark") do
          # Description must be less than 30 characters
          fill_in "description", with: "This is a super long description over 30 Characters"
          click_button "save_bookmark"
        end
        expect(page).to have_content "Error updating Bookmark. [\"Description is too long"
      end
    end

    context "when url is invalid" do

      before do
        within(".edit_bookmark") do
          fill_in "description", with: bookmark.description
        end
      end

      it "displays error when url is blank" do
        within(".edit_bookmark") do
          # Url is currently filled in - must be replaced with blank string
          fill_in "url", with: ""
          click_button "save_bookmark"
        end
        expect(page).to have_content "Error updating Bookmark. [\"Url can't be blank"
      end

      it "displays error when url is invalid" do
        within(".edit_bookmark") do
          # Url requires http:// to be valid
          fill_in "url", with: "google.com"
          click_button "save_bookmark"
        end
        expect(page).to have_content "Error updating Bookmark. [\"Url is invalid"
      end
    end
  end
end

def sign_out_user
  click_link "sign_out"
  visit topic_path(topic)
end
