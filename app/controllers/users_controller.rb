class UsersController < ApplicationController
   before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

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
    @user = only_current_user
  end

  def update
    @user = only_current_user
    if @user.update_attributes(user_params)
      @user.add_extra_role if params[:user][:role_to_add]
      flash[:success] = "Your account information has been updated!"
      redirect_to user_path(@user)
    else
      render :edit
    end
    # ConfirmationSender.send_confirmation_to(@user)
    # redirect_to user_confirmation_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :status, :email, :location, :phone, :password, :password_confirmation)
    end

    def only_current_user
      if params[:id].to_i == current_user.id
        current_user
      else
        render file: "/public/404"
      end
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
