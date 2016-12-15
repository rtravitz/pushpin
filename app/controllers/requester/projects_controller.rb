class Requester::ProjectsController < ApplicationController
  def new
    @project = Project.new
    @skills = Skill.all
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      flash[:success] = "Created new project: #{@project.name}!"
      redirect_to requester_dashboard_path
    else
      flash[:danger] = "The project did not create. Please try again."
      redirect_to new_requester_project_path
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :location)
  end
end
