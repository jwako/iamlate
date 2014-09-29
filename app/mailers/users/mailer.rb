# -*- encoding: UTF-8 -*-
class Users::Mailer < ActionMailer::Base
  default from: Devise.mailer_sender

  def notify_delay(notification, line, subject, message)
    @user = notification.user
    @line = line
    @subject = subject
    @message = message
    mail(
      :subject => "[#{line}]【#{subject}】のため遅れる可能性があります",
      :return_path => Devise.mailer_sender,
      :to => notification.email
    )
  end

end