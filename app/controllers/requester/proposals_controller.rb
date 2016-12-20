class Requester::ProposalsController < ApplicationController
  def show
    @proposal = Proposal.find(params[:id])
  end

  def edit
    @proposal = Proposal.find(params[:id])
    project = @proposal.project_id
    @proposal.update_attributes(status: "assigned")
    Project.find(project).update_attributes(status: "assigned")
    redirect_to "/requester/dashboard"
    flash[:success] = "You successfully awarded this project to a professional!"
  end

  def update

  end
end
