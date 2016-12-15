require 'rails_helper'

feature "Professional user visits the site" do
  context "professional visits the professional dashboard" do
    it "shows the pertinent dashboard information" do
      user = create(:user)
      skill = create(:skill)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      user.skills << skill
      visit professional_dashboard_path

      expect(page).to have_content("Welcome to Your Professional Dashboard")
      expect(page).to have_content(user.skills.first.name)
      expect(page).to have_content("Your Skills")
      expect(page).to have_content("Possible Requests")
      expect(page).to have_content("Active Projects")
    end
  end
end
