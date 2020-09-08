class UserMailer < ApplicationMailer
  default from: "kakame1605@gmail.com"

  def sample_email user
    @user = user
    mail to: @user.email, subject: "Sample Email"
  end

end
