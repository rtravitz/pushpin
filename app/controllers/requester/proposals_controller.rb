class Requester::ProposalsController < ApplicationController
  def show
    @proposal = Proposal.find(params[:id])
    @message = Message.new
  end
end
