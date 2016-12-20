require 'rails_helper'

feature "As a logged in requester" do
  scenario "I can rate a professional" do
    requester = create(:user)
    role_1 = create(:role, title: "requester")
    professional = create(:user)
    role_2 = create(:role, title: "professional")
    requester.roles << role_1
    professional.roles << role_2
    project = create(:project, status: "complete")
    requester.projects << project
    proposal = create(:proposal, project: project, user: professional)

    login(requester)
    visit requester_dashboard_path(requester)

    expect(page).to have_content(project.name)

    click_on(project.name)

    expect(page).to have_content(project.status)
    expect(page).to have_content("Rate This Professional: #{professional.name}")

    fill_in "rating[score]", with: 5

    click_on "Create Rating"

    expect(current_path).to eq(requester_dashboard_path(requester))
    expect(professional.ratings.last.score).to eq(5.0)
    expect(page).to have_content("Thanks for rating #{professional.name}!")
  end
end
