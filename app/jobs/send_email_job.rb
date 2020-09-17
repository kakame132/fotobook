class SendEmailJob < ApplicationJob
  queue_as :default

  def perform user
    UserMailer.delete_email(user).deliver_now
  end
end
