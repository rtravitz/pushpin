require 'rails_helper'

RSpec.describe Skill, type: :model do
  context "validations" do
    it "is invalid without a name" do
      skill = Skill.create()

      expect(skill).to_not be_valid
    end
  end

  context 
end
