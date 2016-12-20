require "rails_helper"

describe "user updates their message" do
  context "requester visits a proposal show" do
    it "edits a message" do
      user1, user2 = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user1.roles << requester
      user2.roles << professional
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)
      message = proposal.messages.create(body: "test body", user: user1)

      visit requester_proposal_path(proposal)
      within("#message-#{message.id}") do
        click_on "Edit"
      end

      fill_in :message_body, with: "Uptown Girl"
      click_on "Update"

      expect(current_path).to eq(requester_proposal_path(proposal))
      within("#message-#{message.id}") do
        expect(page).to have_content("Uptown Girl")
      end
    end
  end
end
