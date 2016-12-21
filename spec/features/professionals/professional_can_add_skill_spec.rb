require 'rails_helper'

feature "As a logged in professional" do
  scenario "I can add a skill to my dashboard" do
    user = create(:user)
    new_skill = create(:skill, name: "shoveling")
    user.skills << create(:skill)
    user.roles << create(:role, title: "professional")

    login(user)

    visit professional_dashboard_path

    within ".professional_add_skill" do
      select "shoveling", from: "skill[skill_id]"
      click_on "Add this skill!"
    end

    expect(page).to have_content("Welcome to Your Professional Dashboard")
    expect(page).to have_content(user.skills.last.name)
    expect(page).to have_content("Your Skills")
    expect(page).to have_content("Created new skill!")
  end
end
