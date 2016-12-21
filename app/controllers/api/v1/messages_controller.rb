class Api::V1::MessagesController < ApiController
  before_action :authenticate!

  def index
    messages = Message.by_proposal(params[:proposal])
    render json: messages
  end

  def create
    proposal = Proposal.find(params[:proposal])
    message = proposal.messages.create(message_params(@user))
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

    def authenticate!
      @user = User.find_by(api_key: params[:api_key])
      return true if @user
      render json: { message: "You are not authorized!"}, status: 403
    end
end
