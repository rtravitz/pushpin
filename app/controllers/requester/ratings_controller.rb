class Requester::RatingsController < ApplicationController

  def create
    @rating = Rating.create!(score: params[:rating][:score], user_id: params[:professional], giver_id: current_user.id)
    redirect_to requester_dashboard_path(current_user)
  end

  private
    def rating_params
      params.require(:rating).permit(:score, :user_id, giver_id: current_user.id)
    end
end
