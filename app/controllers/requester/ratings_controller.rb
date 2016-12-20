class Requester::RatingsController < ApplicationController

  def create
    rating = Rating.new(score: params[:rating][:score], user_id: params[:professional], giver_id: current_user.id)
    if !rating.save
      redirect_to requester_project_path(current_user)
      flash[:warning] = "Something went wrong. Please try again."
    else
      redirect_to requester_dashboard_path(current_user)
      flash[:success] = "Thanks for rating #{rating.user.name}!"
    end
  end

  private
    def rating_params
      params.require(:rating).permit(:score, :user_id, giver_id: current_user.id)
    end
end
