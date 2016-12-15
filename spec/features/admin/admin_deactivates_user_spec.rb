require 'rails_helper'

feature "Admin deactivates a user" do
  scenario "admin visits dashboard" do

    admin_role = create(:role, title: "admin")
    admin = create(:user)
    admin.roles << admin_role

    requester_role = create(:role, title: "requester")
    requester = create(:user)
    requester.roles << requester_role

    visit login_path
    fill_in :email, with: admin.email
    fill_in :password, with: admin.password

    click_on "Login"

    expect(current_path).to eq(admin_dashboard_path(admin))
    expect(page).to have_content(admin.name)
    expect(page).to have_content(requester.name)

    within "##{requester.id}" do
      click_button "Deactivate"
    end

    requester = User.all.last.status
    expect(requester).to eq("inactive")

  end
end
