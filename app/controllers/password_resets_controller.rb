class PasswordResetsController < ApplicationController
  def new
    flash.clear
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_password_reset_token
      PasswordMailer.reset_email(@user).deliver_now
    end
    redirect_to login_path, notice: "If that email exists, a reset link has been sent."
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
    if @user.nil? || @user.password_reset_expired?
      redirect_to new_password_reset_path, alert: "Reset link is invalid or expired."
    end
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user.nil? || @user.password_reset_expired?
      redirect_to new_password_reset_path, alert: "Reset link is invalid or expired."
    elsif @user.update(password_params)
      @user.update_columns(password_reset_token: nil, password_reset_sent_at: nil)
      redirect_to login_path, notice: "Password successfully reset. Please log in."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
