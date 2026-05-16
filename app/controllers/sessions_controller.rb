class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end

  def omniauth
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_path, notice: "Welcome, #{auth[:info][:nickname]}!"
  end

  def failure
    redirect_to root_path, alert: "Twitter auth failed: #{params[:message]}"
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Signed out"
  end
end
