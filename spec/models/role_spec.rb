require 'rails_helper'

RSpec.describe Role, type: :model do
  context "validations" do
    it "is invalid without a title" do
      role = Role.new

      expect(Role.new).to be_invalid
    end

    it "is valid with a title" do
      role = Role.new(title: "title")

      expect(role).to be_valid
    end

    it "is invalid if the title is not unique" do
      Role.create(title: "title")
      role = Role.new(title: "title")

      expect(role).to be_invalid
    end

    it "is valid if the title is unique" do
      Role.create(title: "title")
      role = Role.new(title: "other title")

      expect(role).to be_valid
    end
  end

  context "relationships" do
    it "has many user_roles" do
      role = Role.new(title: "title")

      expect(role).to respond_to(:user_roles)
    end

    it "has many userss" do
      role = Role.new(title: "title")

      expect(role).to respond_to(:users)
    end
  end

  context ".signup_roles" do
    it "returns only requester and professional roles" do
      admin = create(:role, title: "admin")
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")

      expect(Role.signup_roles).not_to include(admin)
      expect(Role.signup_roles).to include(requester, professional)

      Role.signup_roles.each do |role|
        expect(role).to be_instance_of(Role)
      end
    end
  end
end
