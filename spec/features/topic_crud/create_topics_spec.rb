require 'rails_helper'

describe "Creation of topics", js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit topics_path
  end

  it "displays form to create topic" do
    expect( page ).to have_selector(:link_or_button, "Create Topic")
  end

  context "with valid title" do
    
    before do
      fill_in "title", with: "New Topic"
      click_button "create_topic"
    end

    it "displays newly created topic", js: true do
      expect( page ).to have_content "New Topic"
    end
  end

  context "with invalid title" do

    it "displays error with no title", js: true do
      click_button "create_topic"
      expect( page ).to have_content "Error Creating Topic. Please Try Again"
    end

    it "displays error with too short title", js: true do
      fill_in "title", with: "New"
      click_button "create_topic"
      expect( page ).to have_content "Error Creating Topic. Please Try Again"
    end
  end
end