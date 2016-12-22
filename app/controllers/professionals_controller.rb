class ProfessionalsController < ApplicationController
  def index
    @professionals = User.professionals
  end

  def show
    @professional = User.find(params[:id])
    @skill = Skill.find(params[:skill]) if params[:skill]
  end
end
