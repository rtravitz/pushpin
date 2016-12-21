require 'rails_helper'

feature "Guest user visits the root" do
  scenario "they can see options to select a needed service" do
    create_list(:skill, 4)
    visit root_path

    expect(page).to have_content("bricklaying")
    expect(page).to have_content("snuggling")
  end

  context "they click on 'Browse Professionals'" do
    scenario "they see an index of professionals" do
      requester, professional, admin = create_list(:role, 3)
      user_list = create_list(:user, 4)
      user_list.each do |user|
        user.roles << professional
      end
      first = user_list.first
      last = user_list.last

      visit root_path
      click_link "Browse Professionals"

      expect(current_path).to eq("/professionals")
      expect(page).to have_content(first.name)
      expect(page).to have_content(last.name)
      expect(page).to have_content(first.location)
    end
  end
end
