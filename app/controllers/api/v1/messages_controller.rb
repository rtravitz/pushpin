class Api::V1::MessagesController < ApiController
  respond_to :json
  before_action: authenticate!

  def index
    messages = Message.by_proposal(params[:proposal])
    render json: messages
  end

  def create
    proposal = Proposal.find(params[:proposal])
    if authenticate!
      message = proposal.messages.create(message_params(user))
    end
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
      return true if User.find_by(api_key: params[:api_key])
      render file: "/public/404"
    end
end
