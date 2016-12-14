class Admin::DashboardController < ApplicationController
  def show
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
end
