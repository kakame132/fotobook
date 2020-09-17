class UserMailer < ApplicationMailer
  default from: "kakame1605@gmail.com"

  def sample_email user
    @user = user
    mail to: @user.email, subject: "Sample Email"
  end

  def delete_email user
    @user =user
    mail to: @user.email, subject: "Delete Email"
  end

  def inactive_email user
    @user =user
    mail to: @user.email, subject: "Inactive"
  end
end
