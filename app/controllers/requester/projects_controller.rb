class Requester::ProjectsController < ApplicationController
  def new
    @project = Project.new
    @skills = Skill.all
  end

  def create
    @project = Project.new(project_params)
    current_user.projects << @project
    if @project.save
      flash[:success] = "Created new project: #{@project.name}!"
      redirect_to requester_dashboard_path
    else
      flash[:danger] = "The project did not create. Please try again."
      redirect_to new_requester_project_path
    end
  end

  def show
    @project = Project.find_by(slug: params[:project])
    if @project.status == "complete"
      @professional = User.find(@project.proposals.where(status: "assigned").first.user_id)
    end
    @rating = Rating.new
    @requester = current_user
  end

  def edit
    @project = Project.find_by(slug: params[:project])
    @project.update_attributes(status: "complete")
    redirect_to requester_dashboard_path(current_user)
  end

  def update

  end

  private

  def project_params
    params.require(:project).permit(:name, :location, :description, skill_ids: [])
  end
end
