require 'rails_helper'

RSpec.describe Proposal, type: :model do
  context "relationships" do
    it "responds to project" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)

      expect(proposal).to respond_to(:project)
    end

    it "responds to user" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)

      expect(proposal).to respond_to(:user)
    end


  end
end
