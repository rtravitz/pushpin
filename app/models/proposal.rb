class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :messages, dependent: :destroy
  has_many :users, through: :messages, dependent: :destroy
end
