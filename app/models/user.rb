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

  has_many :user_roles
  has_many :roles, through: :user_roles, dependent: :destroy
  has_many :ratings
  has_many :givers, through: :ratings
  has_many :proposals
  has_many :projects
  has_many :messages
  has_many :messages, through: :proposals
  has_many :user_skills
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

  def not_rated?(other_user)
    Rating.where(giver_id: self.id, user_id: other_user.id)
  end
end
