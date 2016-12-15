class Admin::DashboardController < ApplicationController
  def show
    @users = User.all
  end

  def update_user
    binding.pry
  end
end
