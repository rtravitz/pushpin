require 'rails_helper'

RSpec.describe Project, type: :model do
  context "validations" do
    it "it is invalid without a name" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.new(status: "active", user: user)

      expect(project).to_not be_valid
    end

    it "it is invalid without a user" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.new(status: "active", name: "Name")

      expect(project).to_not be_valid
    end


    it "it is valid with a name" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.new(name: "Name", user: user, status: "active")

      expect(project).to be_valid
    end
  end

  context "relationships" do
    it "responds to user" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.new(name: "Name", user: user, status: "active")

      expect(project).to respond_to(:user)
    end

    it "responds to proposals" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)

      expect(project).to respond_to(:proposals)
    end

    it "responds to users" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)

      expect(project).to respond_to(:users)
    end

    it "responds to messages" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)
      message = Message.create(user: user, proposal: proposal, image_url: "http", body: "body of text")

      expect(project).to respond_to(:messages)
    end

    it "responds to project_skills" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      skill = Skill.create(name: "Skill")
      project_skill = ProjectSkill.create(project: project, skill: skill)

      expect(project).to respond_to(:project_skills)
    end

    it "responds to skills" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      skill = Skill.create(name: "Skill")
      project_skill = ProjectSkill.create(project: project, skill: skill)

      expect(project).to respond_to(:skills)
    end







  end
end
