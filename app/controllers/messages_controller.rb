class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    proposal = Proposal.find(params[:proposal_id])
    message.user = current_user
    flash[:danger] = "Your message did not send. Please try again." unless message.save
    redirect_decision(proposal)
  end

  private

    def message_params
      params.require(:message).permit(:body, :proposal_id)
    end

    def redirect_decision(proposal)
      if current_user == proposal.user
        redirect_to professional_proposal_path(proposal)
      else
        redirect_to requester_proposal_path(proposal)
      end
    end
end
