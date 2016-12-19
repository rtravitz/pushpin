class RequestersController < ApplicationController

  def show
    @requester = User.find(params[:id])
  end

end
