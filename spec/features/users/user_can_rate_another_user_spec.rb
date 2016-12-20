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

    within "#completed-projects" do
      click_on(project.name)
    end

    expect(page).to have_content(project.status)
    expect(page).to have_content("Rate This Professional: #{professional.name}")

    fill_in "rating[score]", with: 5

    click_on "Create Rating"

    expect(current_path).to eq(requester_dashboard_path(requester))
    expect(professional.ratings.last.score).to eq(5.0)
    expect(page).to have_content("Thanks for rating this professional!")
  end

  scenario "I can see professional's average rating" do
    requester_1, requester_2 = create_list(:user, 2)
    role_1 = create(:role, title: "requester")
    professional = create(:user)
    role_2 = create(:role, title: "professional")
    requester_1.roles << role_1
    requester_2.roles << role_1
    professional.roles << role_2
    project_1, project_2 = create_list(:project, 2, status: "complete")
    project_3 = create(:project)
    requester_1.projects << project_1
    requester_1.projects << project_3
    requester_2.projects << project_2

    proposal_1 = create(:proposal, project: project_1, user: professional)
    proposal_2 = create(:proposal, project: project_2, user: professional)
    proposal_3 = create(:proposal, project: project_3, user: professional)
    create(:rating, score: 5, user: professional, giver: requester_1)
    create(:rating, score: 3, user: professional, giver: requester_2)

    login(requester_1)

    visit professional_path(professional)

    expect(page).to have_content(professional.name)
    expect(page).to have_content(professional.average_rating)
  end
end
