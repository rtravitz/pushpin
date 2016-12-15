require "rails_helper"

describe "requester dashboard" do
  scenario "a requester visits their dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit requester_dashboard_path(user)
    save_and_open_page

    expect(page).to have_content "Requester"
    expect(page).to have_content "Projects"
    expect(page).to have_content "Proposals"
    # add expect links
    # add specific content
  end
end
