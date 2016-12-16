require "rails_helper"

describe "requester dashboard" do
  scenario "a requester visits their dashboard" do
    user = create(:user)
    role = Role.create(title: "requester")
    user.roles << role

    login(user)

    visit requester_dashboard_path(user)

    expect(page).to have_content "Requester"
    expect(page).to have_content "Projects"
    expect(page).to have_content "Proposals"
    # add expect links
    # add specific content
  end

  scenario "a requester sees their projects and proposals" do
    user = create(:user)
    role = Role.create(title: "requester")
    user.roles << role
    project = user.projects.create!(name: "Name", status: "unassigned")
    proposal = user.proposals.create!(project: project)

    login(user)
    
    visit requester_dashboard_path(user)

    expect(page).to have_content "#{project.name}"
    expect(page).to have_content "#{proposal.id}"
  end
end
