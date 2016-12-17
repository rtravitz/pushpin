class Professional::ProjectsController < ApplicationController
  def index
    @projects = current_user.possible_projects_professional
  end
end
