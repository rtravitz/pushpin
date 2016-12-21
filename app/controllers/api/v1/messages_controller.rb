class Api::V1::MessagesController < ApiController

  def index
    messages = Message.by_proposal(params[:proposal])
    render json: messages
  end

  def create
    proposal = Proposal.find(params[:proposal])
    user = User.find_by(api_key: params[:api_key])
    message = proposal.messages.create(body: params[:message][:body], image_url: params[:message][:file], user_id: user)
    render json: message
  end

  private

  # def message_params
  #   params.require(:message).permit(message: [:body, :image_url])
  # end

end
