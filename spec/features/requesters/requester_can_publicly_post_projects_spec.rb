require 'rails_helper'

describe "As a requester" do
  it "I can post projects from my dashboard" do
    user = create(:user)
    skill1, skill2 = create_list(:skill, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit requester_dashboard_path(user)

    click_link("Create New Project")
    expect(page).to have_current_path("/requester/projects/new")

    fill_in "project_name", with: "Fix Bathroom"
    fill_in "project_location", with: "1510 Blake Street"
    click_button("Create Project")

    expect(page).to have_current_path(requester_dashboard_path)
    expect(page).to have_content("Fix Bathroom")
  end
end
