class Professional::RatingsController < ApplicationController

  def create
    project = Project.find(params[:project])
    if Rating.find_by(user_id: params[:requester], giver_id: current_user.id)
      redirect_to "/professional/#{project.slug}"
      flash[:warning] = "Something went wrong. Please try again."
    else
      Rating.create(score: params[:rating][:score], user_id: params[:requester], giver_id: current_user.id, comment: params[:rating][:comment])
      redirect_to professional_dashboard_path(current_user)
      flash[:success] = "Thanks for rating this requester!"
    end
  end

end
