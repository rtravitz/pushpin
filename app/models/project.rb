class Project < ApplicationRecord
  belongs_to :user
  has_many :proposals, dependent: :destroy
  has_many :users, through: :proposals
  has_many :messages, through: :proposals
  has_many :project_skills
  has_many :skills, through: :project_skills

  validates :name, presence: true
  validates :user, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  scope :unassigned, -> { where(status: "unassigned") }

  def generate_slug
    self.slug = "#{name.parameterize}-#{self.id}" if self.name
  end
end
