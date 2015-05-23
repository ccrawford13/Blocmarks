require 'rails_helper'

describe "Creation of topics", js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit topics_path
  end

  context "when user is present" do

    it "displays form to create topic" do
      expect( page ).to have_button "create_topic"
    end

    context "with valid title" do
    
      before do
        fill_in "title", with: "New Topic"
        click_button "create_topic"
      end

      it "displays newly created topic" do
        expect( page ).to have_content "New Topic"
      end
    end

    context "with invalid title" do

      it "displays error message" do
        click_button "create_topic"
        expect( page ).to have_content "Error Creating Topic - Topic must be 5 or more Characters"
      end
    end
  end

  context "with no user present" do

    # Sign out User and view topics#index with no current_user
    before do
      sign_out_user
    end

    it "does not display form to create topic" do
      expect( page ).not_to have_button "create_topic"
    end
  end
end

def sign_out_user
  click_link "sign_out"
  visit topics_path
end