class MessagesController < ApplicationController
  before_action :set_s3_direct_post, only: [:create, :edit, :update]

  def create
    proposal = Proposal.find(params[:proposal_id])
    message = proposal.messages.new(message_params)
    message.user = current_user
    flash[:danger] = "Your message did not send. Please try again." unless message.save
    redirect_decision(proposal)
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(message_params)
      flash[:success] = "You have updated your message!"
    else
      flash[:danger] = "You have failed to update your message"
    end
    redirect_decision(@message.proposal)
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    proposal = Proposal.find(params[:proposal_id])
    redirect_decision(proposal)
  end

  private

    def message_params
      params.require(:message).permit(:body, :image_url)
    end

    def redirect_decision(proposal)
      if current_user == proposal.user
        if proposal.status == "assigned"
          redirect_to professional_project_path(project: proposal.project.slug)
        else
          redirect_to professional_proposal_path(proposal)
        end
      else
        if proposal.status == "assigned"
          redirect_to requester_project_path(project: proposal.project.slug)
        else
          redirect_to requester_proposal_path(proposal)
        end
      end
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
