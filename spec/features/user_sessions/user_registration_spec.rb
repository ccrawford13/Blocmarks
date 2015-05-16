require 'rails_helper'

describe "User registration" do
  Capybara.javascript_driver = :webkit

  let(:user_email) { 'test_user@example.com'}
  let(:user_password) {'password'}
  let(:user_password_confirmation) {'password'}


  context "successful sign up" do
    
    before do
      visit root_path
      click_link "sign_up"
      fill_in "Email", with: user_email
      fill_in "Password", with: user_password
      fill_in "Password confirmation", with: user_password_confirmation
      click_button "sign_up"
    end

    it "displays message about confirmation email" do
      expect( page ).to have_content "A message with a confirmation link has been sent"
    end
  end

  describe "confirmation email" do
    # include EmailSpec::Helpers
    # include EmailSpec::Matchers
    # before do
    #   visit email_trigger_path
    # end
    # open most recent email sent to user_email
    subject { open_email(user_email) }

    # Verify email details
    it { is_expected.to deliver_to(user_email) }
    it { is_expected.to have_body_text(/You can confirm your account/) }
    it { is_expected.to have_body_text(/users\/confirmation\?confirmation/) }
    it { is_expected.to have_subject(/Confirmation instructions/) }

    context "when clicking confirmation link in email" do
      before do
        visit email_trigger_path
        open_email(user_email)
        current_email.click_link 'Confirm my account'
      end

      it "shows confirmation message" do
        expect( page ).to have_content "Your account was successfully confirmed"
      end

      it "confirms user" do
        user = User.find_for_authentication(email: user_email)
        expect( user ).to be_confirmed
      end
    end
  end
end


