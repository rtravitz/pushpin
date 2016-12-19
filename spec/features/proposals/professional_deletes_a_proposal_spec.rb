require "rails_helper"

describe "professional deletes a proposal" do
  context "delete a proposal from professional dashboard" do
    it "removes the proposal" do
      role = create(:role, title: "professional")
      user = create(:user)
      user.roles << role
      proposal = create(:proposal, user: user)
      login(proposal.user)
      visit professional_dashboard_path(proposal.user)

      expect(page).to have_content(proposal.id)

      within(".proposal-#{proposal.id}") do
        click_on "Delete"
      end

      expect(page).to_not have_content("Proposal ID: #{proposal.id}")
    end
  end
end
