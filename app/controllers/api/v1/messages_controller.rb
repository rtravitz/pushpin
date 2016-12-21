class Api::V1::MessagesController < ApiController

  def index
    messages = Message.by_proposal(params[:proposal])
    render json: messages
  end

  def create
    proposal = Proposal.find(params[:proposal])
    user = User.find_by(api_key: params[:api_key])
    binding.pry
    message = proposal.messages.create(message_params(user))
    render json: message
  end

  private

  def message_params(user)
    params.permit(:message).tap do |whitelisted|
      whitelisted[:body] = params[:message][:body]
      whitelisted[:image_url] = params[:message][:image_url]
      whitelisted[:user_id] = user.id
    end
  end
  #
  #   permit(:message).tap do |whitelisted|
  #     whitelisted[:body]
  #
  #      [:body, :image_url])
  # end
  # params.require(:measurement).permit, :message).tap do |whitelisted|
  #     whitelisted[:message] = params[:message]
  #
end
