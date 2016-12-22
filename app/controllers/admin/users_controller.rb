class Admin::UsersController < ApplicationController
  before_action :find_user

  def show
  end

  def update
    if @user.active?
      @user.update_attributes(status: "inactive")
    else
      @user.update_attributes(status: "active")
    end
    redirect_to admin_dashboard_path
  end

  def destroy
    @user.destroy
    flash[:success] = "Successfully deleted a user."
    redirect_to admin_dashboard_path
  end

  private

    def find_user
      @user = User.find(params[:id])
    end
end
