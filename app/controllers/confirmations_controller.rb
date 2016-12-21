class ConfirmationsController < ApplicationController
  def new
    @user = current_user
    ConfirmationSender.send_confirmation_to(@user)

  end

  def update
    @user = current_user
    if @user.verification_code == params[:user][:verification_code]
      session[:authenticated] = true
      @user.update_attributes(password: params[:password])

      flash[:notice] = "You have successfully updated your password!"
      redirect_to "/#{@user.roles.first.title}/dashboard"
    else
      flash.now[:error] = "Verification code is incorrect."
      render :new
    end
  end
end
