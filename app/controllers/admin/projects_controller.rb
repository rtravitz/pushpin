class Admin::ProjectsController < ApplicationController

  def destroy
    project = Project.find(params[:id])
    user = User.find(params[:user_id])
    user.projects.destroy(project)
    flash[:success] = "Successfully deleted a project."
    redirect_to admin_user_path(user)
  end
end
