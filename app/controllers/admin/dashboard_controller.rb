class Admin::DashboardController < ApplicationController
  def show
    @users = User.all
  end

  def update_user
    user = User.find(params[:id])
    if user.status == "active"
      user.update_attributes(status: "inactive")
    else
      user.update_attributes(status: "active")
    end
    redirect_to admin_dashboard_path(current_user)
  end
end
