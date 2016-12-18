class Professional::ProposalsController < ApplicationController

  def new
    @proposal = Proposal.new
    @project = Project.find(params[:project])
  end

  def create
    @proposal = Proposal.create(user: current_user, project_id: params[:project_id])
    binding.pry
  end

  private

    def proposal_params
      params.require(:proposal).permit(:user_id, :project_id)
    end

end
