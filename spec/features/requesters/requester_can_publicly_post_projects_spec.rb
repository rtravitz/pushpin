require 'rails_helper'

describe "As a requester" do
  it "I can post projects from my dashboard" do
    user = create(:user)
    user.roles.create(title: "requester")
    skill1, skill2, skill3 = create_list(:skill, 3)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit requester_dashboard_path

    click_link("Create New Project")
    expect(page).to have_current_path("/requester/projects/new")

    fill_in "project_name", with: "Fix Bathroom"
    fill_in "project_location", with: "1510 Blake Street"
    fill_in "project_description", with: "Why won't you fix it???"
    check "skill-#{skill1.id}"
    check "skill-#{skill3.id}"
    
    click_button("Create Project")

    expect(page).to have_current_path(requester_dashboard_path)
    expect(page).to have_content("Fix Bathroom")
  end
end
