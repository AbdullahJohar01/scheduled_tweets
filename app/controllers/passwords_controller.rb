class PasswordsController < ApplicationController
  before_action :set_user
  before_action :require_login

  def edit
  end

  def update
    if @user.update(password_params)
      redirect_to @user, notice: "Password updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def require_login
    unless current_user == @user
      redirect_to root_path, alert: "You are not authorized to do this."
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
