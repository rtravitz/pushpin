class UsersController < ApplicationController
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
  before_action :only_current_user, except: [:new, :create]

  def show
  end

  def new
    @user = User.new
    @roles = Role.signup_roles
  end

  def create
    role = Role.find(params["user"]["roles"])
    user = User.new(user_params)
    user.api_key = ApiKeyGenerator.generate_key
    if user.save
      user.roles << role
      session[:user_id] = user.id
      redirect_to "/#{user.roles.first.title}/dashboard"
    else
      redirect_to '/signup'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      @user.add_extra_role if params[:user][:role_to_add]
      flash[:success] = "Your account information has been updated!"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :status, :email, :location, :phone, :password, :image)
    end

    def only_current_user
      if params[:id].to_i == current_user.id
        @user = current_user
      else
        render file: "/public/404"
      end
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
