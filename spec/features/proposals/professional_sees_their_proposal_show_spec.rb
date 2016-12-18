require "rails_helper"

# describe "professional visits a proposal" do
#   context "sees a proposal show professional dashboard" do
#     it "removes the proposal" do
#       role = create(:role, title: "professional")
#       user = create(:user)
#       user.roles << role
#       proposal = create(:proposal, user: user)
#       login(proposal.user)
#
#       visit professional_dashboard_path(proposal.user)
#       within(".proposal-#{proposal.id}") do
#         click_on "#{proposal.id}"
#       end
#
#       expect(current_path).to eq(professional_proposal_path(proposal))
#     end
#   end
# end
