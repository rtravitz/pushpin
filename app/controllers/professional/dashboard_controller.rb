class Professional::DashboardController < ApplicationController
  def show
    @professional = current_user
    @skills = Skill.all
    # @possible_projects = Proposal.projects_with_skill_matches
  end
end
