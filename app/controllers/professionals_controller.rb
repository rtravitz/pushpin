class ProfessionalsController < ApplicationController
  def index
    @professionals = User.professionals
  end
end
