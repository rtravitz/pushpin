class Project < ApplicationRecord
  belongs_to :user
  has_many :proposals
  has_many :users, through: :proposals
  has_many :messages, through: :proposals
  has_many :project_skills
  has_many :skills, through: :project_skills

  validates :name, presence: true
  validates :user, presence: true
end
