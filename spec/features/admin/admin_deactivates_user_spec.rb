require 'rails_helper'

feature "Admin deactivates a user" do
  scenario "admin visits dashboard" do
    role = create(:role, title: "admin")
    admin = create(:user)
    admin.roles << role

    visit login_path




    # click "Login"
  end
end
