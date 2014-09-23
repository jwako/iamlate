# -*- encoding: UTF-8 -*-
class Users::Mailer < ActionMailer::Base
  default from: Devise.mailer_sender

  def notify_delay(notification, message)
    @user = notification.user
    @message = message
    mail(
      :subject => "遅れます",
      :return_path => Devise.mailer_sender,
      :to => notification.email
    )
  end

end