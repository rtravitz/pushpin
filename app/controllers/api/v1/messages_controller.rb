class Api::V1::MessagesController < ApplicationController

  def index
    messages = Message.by_proposal(params[:proposal])
    render json: messages
  end

  def create
    proposal = Proposal.find(params[:proposal])
    user = User.find_by(api_key: params[:api_key])
    message = proposal.messages.create(body: params[:message], user: user, image_url: params[:file])
    render json: message
  end

end
