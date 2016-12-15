require 'rails_helper'

feature "Admin deactivates a user" do
  scenario "admin visits dashboard and deactivates a user" do
    admin_role = create(:role, title: "admin")
    admin = create(:user)
    admin.roles << admin_role

    requester_role = create(:role, title: "requester")
    requester = create(:user)
    requester.roles << requester_role

    login(admin)

    visit admin_dashboard_path(admin)

    expect(current_path).to eq(admin_dashboard_path(admin))
    expect(page).to have_content(admin.name)
    expect(page).to have_content(requester.name)

    within "#update_#{requester.id}" do
      click_button "Deactivate"
    end

    requester = User.find(requester.id)
    expect(requester.status).to eq("inactive")
  end
end
