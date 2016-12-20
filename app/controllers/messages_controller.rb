class MessagesController < ApplicationController
  def create
    proposal = Proposal.find(params[:proposal_id])
    message = proposal.messages.new(message_params)
    message.user = current_user
    flash[:danger] = "Your message did not send. Please try again." unless message.save
    redirect_decision(proposal)
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    proposal = Proposal.find(params[:proposal_id])
    redirect_decision(proposal)
  end

  private

    def message_params
      params.require(:message).permit(:body)
    end

    def redirect_decision(proposal)
      if current_user == proposal.user
        redirect_to professional_proposal_path(proposal)
      else
        redirect_to requester_proposal_path(proposal)
      end
    end
end
