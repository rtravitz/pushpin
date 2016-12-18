class Professional::ProjectsController < ApplicationController
  def index
    @projects = current_user.possible_projects_professional
  end

  def show
    @project = Project.find_by(slug: params[:project])
  end
end
