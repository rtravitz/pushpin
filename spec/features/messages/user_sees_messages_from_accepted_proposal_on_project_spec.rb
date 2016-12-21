require 'rails_helper'

feature "As a user with an accepted proposal for a project" do
  context "who is a professional" do
    scenario "my message history transfers to the project" do
      user1, user2 = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user1.roles << requester
      user2.roles << professional
      login(user2)
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)
      message = proposal.messages.create(body: "test body", user: user1)

      visit professional_project_path(project: project.slug)

      expect(page).to_not have_content(message.body)

      project.update_attributes(status: "assigned")
      proposal.update_attributes(status: "assigned")

      visit professional_project_path(project: project.slug)

      expect(page).to have_content("Message Center")
      expect(page).to have_content(message.body)
    end
  end

  context "who is a requester" do
    scenario "my message history transfers to the project" do
      user1, user2 = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user1.roles << requester
      user2.roles << professional
      login(user1)
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)
      message = proposal.messages.create(body: "test body", user: user1)

      visit requester_project_path(project: project.slug)

      expect(page).to_not have_content(message.body)

      project.update_attributes(status: "assigned")
      proposal.update_attributes(status: "assigned")

      visit requester_project_path(project: project.slug)

      expect(page).to have_content("Message Center")
      expect(page).to have_content(message.body)
    end
  end
end
