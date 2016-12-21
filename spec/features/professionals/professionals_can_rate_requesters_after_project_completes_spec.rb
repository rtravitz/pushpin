require 'rails_helper'

feature "As as logged in professional" do
  scenario "I can rate a requester only after completing a project" do
    professional_user = create(:user)
    requester_user = create(:user)
    professional = create(:role, title: "professional")
    requester = create(:role, title: "requester")
    professional_user.roles << professional
    requester_user.roles << requester

    project = create(:project)
    proposal = create(:proposal, project: project, user: professional_user)
    login(professional_user)
    visit professional_project_path(project: project.slug)

    expect(page).to_not have_content("Rate This Requester: #{requester_user.name}")

    project.status = "complete"

    visit professional_project_path(project: project.slug)

    expect(page).to have_content("Rate This Requester: #{requester_user.name}")

    select "5", from: "rating[score]"
    click_on "Create Rating"

    expect(requester_user.ratings.last.score).to eq(5.0)
    expect(page).to have_content("Thanks for rating this requester!")
  end
end
