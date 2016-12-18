require 'rails_helper'

RSpec.describe Rating, type: :model do
  context "relationships" do

    let(:user) { create(:user) }
    let(:rating) { Rating.new(user: user) }

    it "belongs to a user" do
      expect(rating).to respond_to(:user)
    end

    it "belongs to a giver" do
      expect(rating).to respond_to(:giver)
    end
  end
end
