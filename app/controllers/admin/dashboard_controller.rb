class Admin::DashboardController < ApplicationController
  def show
    @users = User.all.sort
  end
end
