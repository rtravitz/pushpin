class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :messages
  has_many :users, through: :messages

  def self.projects_with_skill_matches
    binding.pry
    project.skills.each do |skill|
      skill.name
    end
  end

end
