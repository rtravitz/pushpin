class Admin::ProposalsController < ApplicationController

  def destroy
    proposal = Proposal.find(params[:id])
    user = User.find(params[:user_id])
    user.proposals.destroy(proposal)
    flash[:success] = "Successfully deleted a proposal."
    redirect_to admin_user_path(user)
  end

end
