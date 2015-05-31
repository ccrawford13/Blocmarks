require 'rails_helper'

describe "Liking bookmarks", js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  before do
    login_as(user, scope: :user)
    visit topic_path(topic)
  end

  context "when user is present" do
    # Will add like_policy after functionality is stable
    it "displays link to favorite post" do
      expect(page).to have_link "favorite_bookmark"
    end
  end

  context "when no user is present" do
    # Will add like_policy after functionality is stable
    # this will allow authorization of permissions before displaying link to favorite
    xit "hides link to favorite post" do
      expect(page).not_to have_link "favorite_post"
    end
  end

  context "when not favorited" do
    # When Bookmark has not been favorited - display link to add to favorites
    it "displays link to favorite bookmark" do
      expect(page).to have_link "favorite_bookmark"
    end
  end

  context "when favorited" do
    # Toggle as favorited to test changes in state
    before do
      click_link "favorite_post"
    end
    # When Bookmark has been favorited - change styling to show highlighted star
    xit "highlights star when favorited" do
      expect(page).to have_tag("a.fi-star.favorited")
    end
    # When Bookmark has been favorited - display link to remove from favorites
    it "displays link to remove favorite" do
      expect(page).to have_link "remove_favorite"
    end
  end

  # 

end