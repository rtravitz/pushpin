require 'rails_helper'

feature "Admin deactivates a user" do
  scenario "admin visits dashboard" do
    role = create(:role, title: "admin")
    admin = create(:user)
    admin.roles << role

    visit '/'
    save_and_open_page

    # click "Login"
  end
end
