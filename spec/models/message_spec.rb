require 'rails_helper'

RSpec.describe Message, type: :model do
  context "validations" do
    it "is invalid withouth a body" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)
      message = Message.new(user: user, proposal: proposal, image_url: "http")

      expect(message).to_not be_valid
    end

    it "is valid with a body, user, proposal" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)
      message = Message.create(user: user, proposal: proposal, image_url: "http", body: "body")

      expect(message).to be_valid
    end
  end

  context "relationships" do
    it "responds to user" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)
      message = Message.create(user: user, proposal: proposal, image_url: "http", body: "body")

      expect(message).to respond_to(:user)
    end

    it "responds to proposal" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)
      message = Message.create(user: user, proposal: proposal, image_url: "http", body: "body")

      expect(message).to respond_to(:proposal)
    end
  end
end
