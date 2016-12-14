require 'rails_helper'

RSpec.describe UserSkill, type: :model do
  context "relationships" do
    it "responds to user" do
      skill = Skill.create(name: "Typer")
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      user_skill = UserSkill.create(user: user, skill: skill)

      expect(user_skill).to respond_to(:user)
    end

    it "responds to skill" do
      skill = Skill.create(name: "Typer")
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      user_skill = UserSkill.create(user: user, skill: skill)

      expect(user_skill).to respond_to(:skill)
    end

  end
end
