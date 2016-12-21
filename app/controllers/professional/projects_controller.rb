class Professional::ProjectsController < ApplicationController
  def index
    @projects = current_user.possible_projects_professional
  end

  def show
    @project = Project.find_by(slug: params[:project])
    @professional = current_user
    @rating = Rating.new 
  end
end
