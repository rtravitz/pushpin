class Requester::ProposalsController < ApplicationController
  def show
    @proposal = Proposal.find(params[:id])
  end
end
