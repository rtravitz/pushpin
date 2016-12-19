require "rails_helper"

describe "Professional visits a requester profile page" do
  context "they link from a proposal" do
    it "displays a requester's information" do
      req_role = create(:role, title: "requester")
      prof_role = create(:role, title: "professional")
      user1, user2 = create_list(:user, 2)
      user1.roles << req_role
      user2.roles << prof_role
      project = create(:project, user: user1, name: "TestName")
      proposal = Proposal.create(project: project, user: user2)
      login(user2)

      visit professional_proposal_path(proposal)
      click_on "#{user1.name}"

      expect(current_path).to eq(requester_path(user1))
      expect(page).to have_content("#{user1.name}'s Profile")
      expect(page).to have_content("Location: #{user1.location}")
      expect(page).to have_css "img[src*='#{user1.image}']"
    end
  end

end
