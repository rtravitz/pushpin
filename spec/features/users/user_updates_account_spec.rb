require 'rails_helper'

describe "User updates account information" do
  context "user resets password" do
    xit "requires two factor authentication" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_user_path(user)

      click_on "Send me a verification code!"

      expect(current_path).to eq(user_confirmation_path(user))

      fill_in 'Verification Code', with: "#{user.verification_code}"
      fill_in 'New Password', with: "password123"
      click_on 'Reset Password'

      expect(page).to have_content("You successfully updated your password!")
      expect(current_path).to eq()
    end
  end

  context "user updates account information" do
    it "updated information is stored" do
      user = create(:user)

      login(user)

      visit

    end
  end

end
