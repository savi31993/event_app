class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user
      if user.authenticate(params[:session][:password])
        login(user.id)
        redirect_to user
      else
        flash.now[:danger] = "Incorrect password!"
        render 'new'
      end
    else
      flash.now[:danger] = "No such user found!"
      render 'new'
    end
  end

  def destroy
    logout
  end
end
