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

  
end
