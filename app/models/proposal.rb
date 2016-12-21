class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :messages, dependent: :destroy
  has_many :users, through: :messages, dependent: :destroy

  scope :unassigned, -> { where(status: "unassigned") }

  def messages_by_most_recent
    messages.reverse
  end

  def self.assigned
    find_by(status: "assigned")
  end
end
