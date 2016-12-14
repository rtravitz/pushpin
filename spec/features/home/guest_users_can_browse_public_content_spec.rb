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
      
    end
  end
end
