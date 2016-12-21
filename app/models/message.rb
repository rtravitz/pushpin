class Message < ApplicationRecord
  belongs_to :user
  belongs_to :proposal

  def self.by_proposal(proposal_id)
    proposal = Proposal.find(proposal_id)
    proposal.messages_by_most_recent
  end

end
