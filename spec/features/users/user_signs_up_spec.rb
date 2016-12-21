require 'rails_helper'
feature "User signs up for an account" do
  scenario "requester signs up" do
    requester_role = create(:role, title: "requester")
    professional_role = create(:role, title: "professional")

    visit signup_path

    fill_in "user[name]", with: "Ali"
    fill_in "user[username]", with: "al"
    fill_in "user[email]", with: "al@alisher.com"
    fill_in "user[location]", with: "Denver"
    fill_in "user[phone]", with: "3330003333"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    select "requester", from: "user_roles"
    click_on "Submit"

    expect(current_path).to eq(requester_dashboard_path)
    expect(page).to have_content("Requester")
    expect(User.last.api_key.length).to eq(32)
  end

  scenario "professional signs up" do
    requester_role = create(:role, title: "requester")
    professional_role = create(:role, title: "professional")

    visit signup_path

    fill_in "user[name]", with: "Ali"
    fill_in "user[username]", with: "al"
    fill_in "user[email]", with: "al@alisher.com"
    fill_in "user[location]", with: "Denver"
    fill_in "user[phone]", with: "3330003333"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    select "professional", from: "user_roles"
    click_on "Submit"

    expect(current_path).to eq(professional_dashboard_path)
    expect(page).to have_content("Welcome to Your Professional Dashboard")
  end
end
