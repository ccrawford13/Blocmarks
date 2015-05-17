require 'rails_helper'

describe "User links" do

  context "when no user exists" do

    before do
      visit root_path
    end
  
    it "displays user information as label" do
      within(".right-off-canvas-menu") do
        expect( page ).to have_content "User Information"
      end
    end

    it "displays sign up link" do
      within(".right-off-canvas-menu") do
        expect( page ).to have_link "sign_up"
      end
    end

    it "displays sign in link" do
      within(".right-off-canvas-menu") do
        expect( page ).to have_link "sign_in"
      end
    end
  end

  context "when user exists" do
    
    let(:user) { build(:user) }

    before do
      login_as(user, scope: :user)
      visit root_path
    end

    it "displays user's first name as label" do
      within(".right-off-canvas-menu") do
        expect( page ).to have_content user.first_name
      end
    end

    it "displays link to user's profile" do
      within(".right-off-canvas-menu") do
        expect( page ).to have_link "my_profile"
      end
    end

    it "displays link to edit user" do
      within(".right-off-canvas-menu") do
        expect( page ).to have_link "edit_user"
      end
    end

    it "displays link to sign out" do
      within(".right-off-canvas-menu") do
        expect( page ).to have_link "sign_out"
      end
    end
  end
end