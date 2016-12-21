class Requester::DashboardController < ApplicationController

  def show
    @user = current_user
  end
end
