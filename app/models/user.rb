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
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :user_skills
  has_many :skills, through: :user_skills, dependent: :destroy

  def self.professionals
    Role.find_by(title: "professional").users
  end

  def active?
    status == "active"
  end
end
