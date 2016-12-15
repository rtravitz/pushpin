require 'rails_helper'

describe "As a requester" do
  it "I can post projects from my dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit requester_dashboard_path(user)

    click_button("Create New Project")
    expect(page).to have_current_path("/#{user.username}/projects/new")

    fill_in "name", with: "Fix Bathroom"
    fill_in "location", with: "1510 Blake Street"
    fill_in "skill", with: "Plumbing"
    click_button("Create Project")

    expect(page).to have_current_path(requester_dashboard_path)
    expect(page).to have_content("Fix Bathroom")
  end
end
