class Requester::DashboardController < ApplicationController

  def show
    @user = current_user
    binding.pry
  end

end
