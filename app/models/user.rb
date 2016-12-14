class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  validates :username, presence: true, uniqueness: true
  validates :status, presence: true
  validates :location, presence: true
  validates :phone, presence: true

  has_secure_password

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :ratings
  has_many :givers, through: :ratings
end
