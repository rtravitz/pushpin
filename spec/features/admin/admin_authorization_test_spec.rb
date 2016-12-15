require 'rails_helper'

feature "Only admin should be able to view admin dashboard" do
  scenario "a requester visits admin dashboard" do
    requester_role = create(:role, title: "requester")
    requester = create(:user)
    requester.roles << requester_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(requester)

    visit "/admin/dashboard/#{requester.id}"

    expect(current_path).to eq(admin_dashboard_path(requester))
  end
end
