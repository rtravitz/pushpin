class Project < ApplicationRecord
  belongs_to :user
  has_many :proposals
  has_many :users, through: :proposals
  has_many :messages, through: :proposals
  has_many :project_skills
  has_many :skills, through: :project_skills

  validates :name, presence: true
  validates :user, presence: true


  # def self.possible_projects(user_id)
  #
  #   user = User.find(user_id)
  #   user.skills.each do |skill|
  #     skill.projects
  #   end
  # end

  validates :slug, uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = "#{name.parameterize}-#{self.id}"
  end

end
