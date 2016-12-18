class UsersController < ApplicationController
  def show
    @user = only_current_user
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
    @user = only_current_user
    @roles = Role.signup_roles
    ConfirmationSender.send_confirmation_to(@user)
    redirect_to user_confirmation_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :status, :email, :location, :phone, :password, :password_confirmation)
    end

    # below method was added to account for the edge case
    # when users try to go to someone else's page,
    # they can only see their own info regardless
    # but this stops them from even trying
    def only_current_user
      if params[:id].to_i == current_user.id
        current_user
      else
        render file: "/public/404"
      end
    end
end
