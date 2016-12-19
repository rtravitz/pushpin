require "rails_helper"

describe "professional visits a proposal" do
  before :each do
    role = create(:role, title: "professional")
    user = create(:user)
    user.roles << role
    @proposal = create(:proposal, user: user)
    login(@proposal.user)
  end
  context "sees a proposal show professional dashboard" do
    it "sees the proposal" do

      visit professional_dashboard_path(@proposal.user)
      within(".proposal-#{@proposal.id}") do
        click_on "#{@proposal.id}"
      end

      expect(current_path).to eq(professional_proposal_path(@proposal))
      expect(page).to have_content("Proposal ID: #{@proposal.id}")
      expect(page).to have_content("Project Name: #{@proposal.project.name}")
      expect(page).to have_content("Project Requester: #{@proposal.project.user.name}")
      expect(page).to have_content("Message Center")
    end
  end

end
