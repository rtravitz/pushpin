require "rails_helper"

describe "requester dashboard" do
  scenario "a requester visits their dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit requester_dashboard_path(user)

    expect(page).to have_content "Requester"
    expect(page).to have_content "Projects"
    expect(page).to have_content "Proposals"
    # add expect links
    # add specific content
  end

  scenario "a requester sees their projects and proposals" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    project = user.projects.create!(name: "Name", status: "unassigned")
    proposal = user.proposals.create!(project: project)
    visit requester_dashboard_path(user)

    expect(page).to have_content "#{project.name}"
    expect(page).to have_content "#{proposal.id}"
  end
end
