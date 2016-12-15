require 'rails_helper'

feature "Admin deletes a user" do
  scenario "admin visits dashboard and deletes a user" do
    admin_role = create(:role, title: "admin")
    admin = create(:user)
    admin.roles << admin_role

    professional_role = create(:role, title: "professional")
    professional = create(:user)
    professional.roles << professional_role
    skill = create(:skill)
    professional.skills << skill

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path(admin)

    expect(current_path).to eq(admin_dashboard_path(admin))
    expect(page).to have_content(admin.name)
    expect(page).to have_content(professional.name)

    within "#delete_#{professional.id}" do
      click_button "Delete"
    end

    professional = User.find_by(id: professional.id)
    expect(professional).to eq(nil)
    expect(Skill.first).to eq(skill)
    expect(Role.last).to eq(professional_role)
  end
end
