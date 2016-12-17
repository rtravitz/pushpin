require 'rails_helper'

feature "As a requester when I visit my existing project page" do
  scenario "I can see the information for my project" do
    user = create(:user)
    requester, professional, admin = create_list(:role, 3)
    project = create(:project)
    user.roles << requester
    user.projects << project
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit requester_project_path(project: project.slug)

    expect(page).to have_content(project.name)
  end
end
