class UsersController < ApplicationController
  def show

  end

  def new
    @user = User.new
    @roles = Role.signup_roles
  end

  def create
    role = Role.find(params["user"]["roles"])
    user = User.new(user_params)
    if user.save
      user.roles << role
      session[:user_id] = user.id
      redirect_to "/#{user.roles.first.title}/dashboard"
    else
      redirect_to '/signup'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    ConfirmationSender.send_confirmation_to(@user)
    redirect_to user_confirmation_path
  end

private

  def user_params
    params.require(:user).permit(:name, :username, :status, :email, :location, :phone, :password, :password_confirmation)
  end
end
