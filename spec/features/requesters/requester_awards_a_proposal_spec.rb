require 'rails_helper'

describe "As a logged in requester" do
  scenario "I can award a proposal to a professional" do
    requester = create(:user)
    role = create(:role, title: "requester")
    requester.roles << role
    professional_1, professional_2 = create_list(:user, 2)
    role_2 = create(:role, title: "professional")
    professional_1.roles << role_2
    professional_2.roles << role_2
    project = create(:project)
    requester.projects << project
    proposal_1 = create(:proposal, project: project, user: professional_1)
    proposal_2 = create(:proposal, project: project, user: professional_2)

    login(requester)

    visit requester_dashboard_path(requester)

    within "#proposals" do
      click_on proposal_1.id
    end


  end
end
