class Message < ApplicationRecord
  belongs_to :user
  belongs_to :proposal
  
  validates :body, presence: true
end
