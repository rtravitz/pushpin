class ProfessionalsController < ApplicationController
  def index
    @professionals = User.professionals
  end

  def show
    @professional = User.find(params[:id])
  end
end
