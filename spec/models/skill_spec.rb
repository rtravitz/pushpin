require 'rails_helper'

RSpec.describe Skill, type: :model do
  context "validations" do
    it "is invalid without a name" do
      skill = Skill.new()

      expect(skill).to_not be_valid
    end
  end

  context "relationships" do
    it "responds to user_skills" do
      skill = Skill.create(name: "Typer")
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      user_skill = UserSkill.create(user: user, skill: skill)

      expect(skill).to respond_to(:user_skills)
    end

    it "responds to users" do
      skill = Skill.create(name: "Typer")
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      user_skill = UserSkill.create(user: user, skill: skill)

      expect(skill).to respond_to(:users)
    end

    it "responds to project_skills" do
      skill = Skill.create(name: "Typer")
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(user: user, name: "Name", status: "unassigned")
      project_skill = ProjectSkill.create(project: project, skill: skill)

      expect(skill).to respond_to(:project_skills)
    end

    it "responds to project_skills" do
      skill = Skill.create(name: "Typer")
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(user: user, name: "Name", status: "unassigned")
      project_skill = ProjectSkill.create(project: project, skill: skill)

      expect(skill).to respond_to(:projects)
    end





  end
end
