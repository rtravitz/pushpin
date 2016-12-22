class Professional::ProposalsController < ApplicationController
  before_action :set_s3_direct_post, only: [:show, :create, :new]

  def show
    @proposal = Proposal.find(params[:id])
    @message = Message.new
  end

  def new
    @proposal = Proposal.new
    @project = Project.find(params[:project])
  end

  def create
    @proposal = Proposal.new(user: current_user, project_id: params[:project_id])
    if @proposal.save
      @proposal.messages.create(image_url: params[:image_url], user_id: current_user.id)
      flash[:success] = "You have submitted a proposal for #{@proposal.project.name}"
      redirect_to professional_dashboard_path(current_user)
    else
      flash[:warning] = "Proposal not submitted, please try again."
      render :new
    end
  end

  def destroy
    proposal = Proposal.find(params[:id])
    if proposal.destroy
      current_user.proposals.delete(proposal) #if  Rails.env == "test"
      flash[:success] = "You have successfully deleted Proposal: #{proposal.id}"
    end
    redirect_to professional_dashboard_path
  end

  private

    def proposal_params
      params.require(:proposal).permit(:user_id, :project_id)
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end

end
