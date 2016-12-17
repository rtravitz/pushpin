require 'rails_helper'

feature "As a requester when I visit my existing project page" do
  scenario "I can see the information for my project" do
    user = create(:user)
    project = create(:project)
    user.projects << project

    visit requester_project_path(project: project.slug)

    expect(page).to have_content(project.name)
  end
end
