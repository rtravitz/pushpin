class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :messages, dependent: :destroy
  has_many :users, through: :messages, dependent: :destroy

  def messages_by_most_recent
    messages.reverse
  end
end
