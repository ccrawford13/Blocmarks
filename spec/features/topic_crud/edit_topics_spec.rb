require 'rails_helper'

describe "Editing topics", js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic) }

  before do
    create_and_nav_to_topic
  end

  it "displays link to edit topic" do
    expect( page ).to have_link "edit_topic"
  end

  context "when edit link is clicked" do

    before do
      click_link "edit_topic"
    end

    it "displays form to edit topic" do
      within(".edit-form") do
        expect( page ).to have_button("save_changes")
      end
    end

    context "with valid update" do

      it "displays edited topic" do
        within(".edit-form") do
          fill_in "title", with: "New Title"
          click_button "save_changes"
        end
        expect( page ).to have_content "New Title"
      end
    end

    context "with invalid title" do
      
      it "displays error message" do
        within(".edit-form") do
          fill_in "title", with: "new"
          click_button "save_changes"
        end
        expect( page ).to have_content "Error Updating Topic - Topic must be 5 or more characters"
      end
    end
  end
end

def create_and_nav_to_topic
  login_as(user, scope: :user)
  visit topics_path
  fill_in "title", with: topic.title
  click_button "create_topic"
  visit topic_path(topic)
end