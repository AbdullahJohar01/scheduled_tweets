class PasswordMailer < ApplicationMailer
  def reset_email(user)
    @user = user
    @reset_url = edit_password_reset_url(@user.password_reset_token)
    mail(to: @user.email, subject: "Reset Your Password")
  end
end
