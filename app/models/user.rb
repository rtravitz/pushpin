class User < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :ratings
  has_many :givers, through: :ratings
end
