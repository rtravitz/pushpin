require 'rails_helper'

feature "As a logged in professional, on my dashboard" do
  scenario "I can go to browse potential jobs" do
    user = create(:user)
    role_1, role_2, role_3 = create_list(:role, 3)
    user.roles << role_2
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    skills_1, skill_2 = create_list(:skill, 2)
    project_1, project_2, project_3 = create_list(:project, 3)
    project_1.skills << skill_2
    project_3.skills << skill_2
    user.skills << skill_2

    visit professional_dashboard_path
    click_on "Find Work"

    expect(current_path).to eq(professional_projects_path)
    expect(page).to have_content("Potential Projects")
    expect(page).to have_content(project_1.name)
    expect(page).to have_content(project_3.name)
    expect(page).to_not have_content(project_2.name)
  end
end
