class Requester::DashboardController < ApplicationController

  def show
    @user = current_user
    @completed_projects = @user.projects.where(status: "complete")
  end
end
