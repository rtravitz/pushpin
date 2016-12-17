class Professional::DashboardController < ApplicationController
  def show
    @professional = current_user
    @skills = Skill.all

    @possible_projects = Project.joins(skills: :users).where("user_skills.user_id = #{current_user.id}")
  end
end
