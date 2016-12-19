require "rails_helper"

describe "guest sees professionals by skill" do
  context "guest visits a skill show from home" do
    it "displays professionals with that skill" do
      skill = create(:skill)
      prof_role = create(:role, title: "professional")
      user1, user2, user3 = create_list(:user, 3)
      user1.roles << prof_role
      user2.roles << prof_role
      user3.roles << prof_role
      user1.skills << skill
      user2.skills << skill
      user3.skills << skill

      visit home_path
      # select "#{skill.name}" 
    end
  end
end
