class ConfirmationsController < ApplicationController
  def new
    @user = current_user
    redirect_to user_confirmation_path
  end

  def update
    @user = current_user
    ConfirmationSender.send_confirmation_to(@user)
    # redirect_to user_confirmation_path

    binding.pry
    if @user.verification_code == params[:user][:verification_code]

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
