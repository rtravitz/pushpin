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

  context "user goes to user show page" do
    let(:user) { create(:user, name: "jeff") }
    let(:requester_role) { create(:role, title: "requester") }

    it "user can see all existing account information" do
      user.roles << requester_role
      login(user)

      visit user_path(user)

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.location)
      expect(page).to have_content(user.phone)
      expect(page).to have_link("Update account info")
    end

    it "user updates information" do
      user.roles << requester_role
      login(user)

      visit user_path(user)

      expect(page).to have_content("jeff")

      click_link "Update account info"

      expect(current_path).to eq(edit_user_path(user))

      fill_in "user[name]", with: "new name"

      click_on "Update"

      expect(current_path).to eq(user_path(user))
      expect(page).not_to have_content("jeff")
      expect(page).to have_content("new name")
    end

    it "requester user adds a professional role" do
      user.roles << requester_role
      create(:role, title: "professional")
      login(user)

      visit edit_user_path(user)

      select "professional", from: "user[role_to_add]"

      click_on "Update"

      expect(current_path).to eq(user_path(user))
      expect(User.last.roles.count).to eq(2)
      expect(User.last.roles.first).to eq(Role.find_by(title: "requester"))
      expect(User.last.roles.last).to eq(Role.find_by(title: "professional"))
    end

    it "professional user adds a requester role" do
      prof_role = create(:role, title: "professional")
      user.roles << prof_role
      requester_role #calls the above let block
      login(user)

      visit edit_user_path(user)

      select "requester", from: "user[role_to_add]"

      click_on "Update"

      expect(current_path).to eq(user_path(user))
      expect(User.last.roles.count).to eq(2)
      expect(User.last.roles.first).to eq(Role.find_by(title: "professional"))
      expect(User.last.roles.last).to eq(Role.find_by(title: "requester"))
    end
  end
end
