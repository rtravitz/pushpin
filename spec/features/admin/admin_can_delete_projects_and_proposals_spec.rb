require 'rails_helper'

feature "As a logged in admin, when I visit my dashboard" do
  scenario "I can delete projects and proposals" do
    professional, requester, admin = create_list(:user, 3)
    role_admin = create(:role, title: "admin")
    admin.roles << role_admin
    role_professional = create(:role, title: "professional")
    professional.roles << role_professional
    role_requester = create(:role, title: "requester")
    requester.roles << role_requester
    project = create(:project)
    requester.projects << project
    proposal = create(:proposal)
    professional.proposals << proposal
    login(admin)

    visit admin_dashboard_path
    click_link professional.name

    expect(current_path).to eq(admin_user_path(professional))
    expect(page).to have_content(proposal.id)
    click_link "Delete"
    expect(current_path).to eq(admin_user_path(professional))
    expect(page).to_not have_content(proposal.id)

    visit admin_dashboard_path
    click_link requester.name

    expect(current_path).to eq(admin_user_path(requester))
    expect(page).to have_content(project.name)
    click_link "Delete"
    expect(current_path).to eq(admin_user_path(requester))
    expect(page).to_not have_content(project.name)
  end
end
