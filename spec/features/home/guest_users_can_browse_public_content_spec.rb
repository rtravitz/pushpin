require 'rails_helper'

feature "Guest user visits the root" do
  scenario "they can see options to select a needed service" do
    
  end

  scenario "they click on 'Browse Professionals' and see an index of professionals" do
    visit root_path
    click_link "Browse Professionals"
    
  end
end
