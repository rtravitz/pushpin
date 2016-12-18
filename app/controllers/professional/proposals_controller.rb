class Professional::ProposalsController < ApplicationController

  def new
    @proposal = Proposal.new
    @project = Project.find(params[:project])
  end

  def create
    @proposal = Proposal.new(user: current_user, project_id: params[:project_id])
    if @proposal.save
      flash[:success] = "You have submitted a proposal for #{@proposal.project.name}"
      redirect_to professional_dashboard_path(current_user)
    else
      flash[:warning] = "Proposal not submitted, please try again."
      render :new
    end
  end

  private

    def proposal_params
      params.require(:proposal).permit(:user_id, :project_id)
    end

end
