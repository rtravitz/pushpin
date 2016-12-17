class Professional::DashboardController < ApplicationController
  def show
    @professional = current_user
    @skills = Skill.all
    # @projects = Project.projects_with_skill_matches
  end
end
