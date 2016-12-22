require "rails_helper"

describe "guest sees professionals by skill" do
  context "guest visits a skill show from home" do
    it "displays professionals with that skill" do
      skill1 = create(:skill)
      skill2 = create(:skill)
      prof_role = create(:role, title: "professional")
      user1, user2, user3 = create_list(:user, 3)
      user1.roles << prof_role
      user2.roles << prof_role
      user3.roles << prof_role
      user1.skills << skill1
      user2.skills << skill1
      user3.skills << skill2

      visit root_path
      select "#{skill1.name}", from: "skill[skill_id]"
      click_on "Find a Professional"

      expect(current_path).to eq(skills_search_path)
      expect(page).to have_link("#{user1.name}", href: professional_path(user1))
      expect(page).to have_content("#{user1.location}")
      expect(page).to_not have_link("#{user3.name}", href: professional_path(user3))
    end
  end
end
