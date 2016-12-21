class Professional::SkillsController < ApplicationController
  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.find(params[:skill][:skill_id])
    current_user.skills << @skill
    if @skill.save
      flash[:success] = "Created new skill!"
      redirect_to professional_dashboard_path
    end
  end

  def destroy
    skill = Skill.find(params[:id])
    current_user.skills.destroy(skill)
    flash[:info] = "Deleted a skill!"
    redirect_to professional_dashboard_path
  end
end
