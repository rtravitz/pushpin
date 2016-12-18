require 'rails_helper'

RSpec.describe UserRole, type: :model do
  context "relationships" do
    
    let(:user) { create(:user) }
    let(:role) { create(:role) }
    let(:user_role) { UserRole.new(user_id: user.id, role_id: role.id) }

    it "belongs to a user" do
      expect(user_role).to respond_to(:user)
    end

    it "belongs to a role" do
      expect(user_role).to respond_to(:role)
    end
  end
end
