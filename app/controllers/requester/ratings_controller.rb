class Requester::RatingsController < ApplicationController

  def create
    project = Project.find(params[:project])
    if Rating.find_by(user_id: params[:professional], giver_id: current_user.id)
      redirect_to "/requester/#{project.slug}"
      flash[:warning] = "Something went wrong. Please try again."
    else
      Rating.create(score: params[:rating][:score], user_id: params[:professional], giver_id: current_user.id)
      redirect_to requester_dashboard_path(current_user)
      flash[:success] = "Thanks for rating #{rating.user.name}!"
    end
  end

  private
    def rating_params
      params.require(:rating).permit(:score, :user_id, giver_id: current_user.id)
    end
end
