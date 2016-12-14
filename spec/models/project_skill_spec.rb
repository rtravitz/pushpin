require 'rails_helper'

RSpec.describe ProjectSkill, type: :model do
  context "relationships" do
    it "responds to skill" do
      skill = Skill.create(name: "Typer")
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(user: user, name: "Name", status: "unassigned")
      project_skill = ProjectSkill.create(project: project, skill: skill)

      expect(project_skill).to respond_to(:skill)
    end

    it "responds to project" do
      skill = Skill.create(name: "Typer")
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(user: user, name: "Name", status: "unassigned")
      project_skill = ProjectSkill.create(project: project, skill: skill)

      expect(project_skill).to respond_to(:project)
    end

  end
end
