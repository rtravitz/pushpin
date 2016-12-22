class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :username, presence: true, length: { maximum: 50 }
  validates :username, uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, on: :create

  validates :name, presence: true
  validates :status, presence: true
  validates :location, presence: true
  validates :phone, presence: true

  has_secure_password
  validates_confirmation_of :password

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :givers, through: :ratings, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :messages, through: :proposals, dependent: :destroy
  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills, dependent: :destroy

  def self.professionals
    Role.find_by(title: "professional").users
  end

  def active?
    status == "active"
  end

  def admin?
    roles.exists?(title: "admin")
  end

  def professional?
    roles.exists?(title: "professional")
  end

  def requester?
    roles.exists?(title: "requester")
  end

  def possible_projects_professional
    Project.unassigned.joins(skills: :users).where("user_skills.user_id = ?", self.id)
  end

  def role_to_add
    (Role.signup_roles - roles)
  end

  def add_extra_role
    roles << role_to_add
  end

  def average_rating
    ratings.average(:score).to_f
  end

  def completed_projects
    projects.where(status: "complete")
  end

  def current_projects
    projects.where.not(status: "complete")
  end

  def professional_current_projects
    Project.where(id: self.proposals
      .joins(:project)
      .where("proposals.status = ? AND projects.status = ?", "assigned", "assigned")
      .pluck("projects.id"))
  end

  def professional_completed_projects
    Project.where(id: self.proposals
      .joins(:project)
      .where("proposals.status = ? AND projects.status = ?", "assigned", "complete")
      .pluck("projects.id"))
  end

  def not_rated?(other_user)
    Rating.where(giver_id: self.id, user_id: other_user.id).length == 0
  end
end
