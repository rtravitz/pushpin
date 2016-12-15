class Professional::DashboardController < ApplicationController
  def show
    @professional = current_user
    @user_skills = UserSkill.all
    @skills = Skill.all
  end
end
