class Admin::DashboardController < ApplicationController
  def show
    @users = User.all
  end
end
