require "rails_helper"

describe "User deletes a message spec" do
  context "When a requester visits a proposal" do
    scenario "they can delete their message" do
      user1, user2 = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user1.roles << requester
      user2.roles << professional
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)
      message = proposal.messages.create(body: "test body", user: user2)

      visit requester_proposal_path(proposal)
      within("#message-#{message.id}") do
        click_on "Delete"
      end

      save_and_open_page

      expect(page).to_not have_css("#message-#{message.id}")
      expect(page).to_not have_content(message.body)
    end
  end
end
