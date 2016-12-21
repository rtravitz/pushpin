class Api::V1::MessagesController < ApplicationController

  def index
    messages = Message.by_proposal(params[:proposal])
    render json: messages
  end

end
