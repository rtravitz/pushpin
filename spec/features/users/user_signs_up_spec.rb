require 'rails_helper'

feature "User signs up for an account" do
  scenario "requester signs up" do

    visit signup_path

    fill_in "user[name]", with: "Ali"
    fill_in "user[username]", with: "al"
    fill_in "user[email]", with: "al@alisher.com"
    fill_in "user[location]", with: "Denver"
    fill_in "user[phone]", with: "3330003333"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"

    select "requester", :from => "user_roles"

    click_on "Submit"

    expect(current_path).to eq(requester_dashboard_path)
  end
end
