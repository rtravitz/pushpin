require 'rails_helper'

feature "As a logged in professional, on my dashboard" do
  scenario "I can go to browse potential jobs" do
    user, projects = setup
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit professional_dashboard_path
    click_on "Find Work"

    expect(current_path).to eq(professional_projects_path)
    expect(page).to have_content("Potential Projects")
    expect(page).to have_content(projects[0].name)
    expect(page).to have_content(projects[2].name)
    expect(page).to_not have_content(projects[1].name)
  end

  scenario "I can see an individual project matching my skills" do
    user, projects = setup
    project = projects[0]
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit professional_projects_path
    click_on projects.first.name

    expect(current_path).to eq(professional_project_path(project.slug))
    expect(page).to have_content(project.name)
    expect(page).to have_content(project.location)
    expect(page).to have_content(project.description)
  end
end

def setup
  user = create(:user)
  professional = create(:role, title: "professional")
  user.roles << professional
  skills_1, skill_2 = create_list(:skill, 2)
  project_1, project_2, project_3 = create_list(:project, 3)
  project_1.skills << skill_2
  project_3.skills << skill_2
  user.skills << skill_2
  return user, [project_1, project_2, project_3]
end
