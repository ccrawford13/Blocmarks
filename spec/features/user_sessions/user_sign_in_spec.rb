require 'rails_helper'

describe "User sign in" do

  before do
    visit root_path
    click_link "sign_in"
  end

  let(:user) { create(:user) }
  
  context "successful sign in" do
    before do
      user_sign_in
    end

    it "redirect to users#show" do  
      expect( current_path ).to eq user_path(user)
    end

    it "flashes confirmation message" do
      expect( page ).to have_content "Signed in successfully"
    end
  end

  context "unsuccessful sign in" do

    it "requires confirmed user" do
      user.update_attributes(confirmed_at: nil)
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "log_in"
      expect( page ).to have_content "You have to confirm your email address before continuing"
    end

    it "requires correct email" do
      fill_in "Email", with: "notuseremail"
      fill_in "Password", with: user.password
      click_button "log_in"
      expect( page ).to have_content "Invalid email or password"
    end

    it "requires correct password" do
      fill_in "Email", with: user.email
      fill_in "Password", with: "notuserpassword"
      click_button "log_in"
      expect( page ).to have_content "Invalid email or password"
    end
  end
end

def user_sign_in
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "log_in"
end