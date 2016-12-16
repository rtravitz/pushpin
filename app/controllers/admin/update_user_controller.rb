class Admin::UpdateUserController < ApplicationController
  def update_status
    user = User.find(params[:id])
    if user.active?
      user.update_attributes(status: "inactive")
    else
      user.update_attributes(status: "active")
    end
    redirect_to admin_dashboard_path
  end

  def destroy_user
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_dashboard_path
  end
end
