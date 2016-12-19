class SkillsController < ApplicationController
  def show
    @skill = Skill.find(params[:skill][:skill_id])
  end
end
