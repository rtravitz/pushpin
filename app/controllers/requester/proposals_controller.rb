class Requester::ProposalsController < ApplicationController
  def show
    @proposal = Proposal.find(params[:id])
  end

  def edit
    @proposal = Proposal.find(params[:id])
    project = @proposal.project_id
    Project.find(project).update_attributes(status: "assigned")
    redirect_to "/requester/dashboard"
  end

  def update

  end
end
