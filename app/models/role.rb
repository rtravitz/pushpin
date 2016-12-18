class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  validates :title, presence: true, uniqueness: true

  def self.signup_roles
    where(title: ["requester", "professional"])
  end
end
