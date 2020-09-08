class SendEmailJob < ApplicationJob
  queue_as :default

  def perform user
    UserMailer.sample_email(user).deliver_now
  end
end
