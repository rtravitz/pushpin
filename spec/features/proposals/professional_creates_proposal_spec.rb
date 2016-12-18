require "rails_helper"

describe "a professional creates a proposal on a project" do
  context "a professional links to a proposal create from a project show" do
    it "links to a proposal new" do
      prof_role = create(:role, title: "professional")
      requester_role = create(:role, title: "requester")
      user1, user2 = create_list(:user, 2)
      user1.roles << prof_role
      user2.roles << requester_role
      project = create(:project, user: user2)
      login(user1)

      visit professional_project_path(project: project.slug)

      click_on "Create a Proposal"
      expect(current_path).to eq(professional_proposals_new_path)
    end

    it "fills in proposal information" do
      prof_role = create(:role, title: "professional")
      requester_role = create(:role, title: "requester")
      user1, user2 = create_list(:user, 2)
      user1.roles << prof_role
      user2.roles << requester_role
      project = create(:project, user: user2)
      login(user1)

      visit professional_proposals_new_path(project: project.id)

      expect(Proposal.count).to eq(0)
      click_on "Submit a Proposal"

      expect(current_path).to eq(professional_dashboard_path(user1))
      expect(Proposal.count).to eq(1)
    end

  end
end
