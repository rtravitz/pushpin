require 'rails_helper'

feature "Professional user visits the site and adds skill" do
  context "professional visits the professional dashboard" do
    it "allows professional user to add a skill" do
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
    end
  end
end
