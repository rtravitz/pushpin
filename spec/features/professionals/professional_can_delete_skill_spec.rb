require 'rails_helper'

feature "As a logged in professional" do
  scenario "I can visit my dashboard and delete a skill from their profile" do
    user = create(:user)
    new_skill = create(:skill, name: "shoveling")
    user.skills << new_skill
    user.roles << create(:role, title: "professional")

    login(user)

    visit professional_dashboard_path

    within ".list-inline" do
      click_on "Delete"
    end

    expect(page).to have_content("Welcome to Your Professional Dashboard")
    expect(page).to have_content("Deleted a skill!")
  end
end
