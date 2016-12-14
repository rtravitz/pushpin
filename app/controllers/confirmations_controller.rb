class ConfirmationsController < ApplicationController
  def new
    @user = current_user
  end

  def update
    @user = current_user

    if @user.verification_code == params[:verification_code]

      session[:authenticated] = true
      @user.update_attributes(password: params[:password])

      flash[:notice] = "You have successfully updated your password!"
      redirect_to root_path
    else
      flash.now[:error] = "Verification code is incorrect."
      render :new
    end
  end
end
