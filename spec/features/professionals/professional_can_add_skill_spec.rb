require 'rails_helper'

feature "Professional user visits the site and adds skill" do
  context "professional visits the professional dashboard" do
    it "allows professional user to add a skill" do
      user = create(:user)
      user.skills << create(:skill)
      user.roles << create(:role, title: "professional")

      login(user)

      visit professional_dashboard_path

      # fill_in "New Skill", with: "Woodworking"
      # click_on "Add a Skill"

      expect(page).to have_content("Welcome to Your Professional Dashboard")
      expect(page).to have_content(user.skills.last.name)
      expect(page).to have_content("Your Skills")
    end
  end
end
