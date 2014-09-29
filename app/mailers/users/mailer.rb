# -*- encoding: UTF-8 -*-
class Users::Mailer < ActionMailer::Base
  default from: Devise.mailer_sender

  def notify_delay(notification, line, subject, message)
    @user = notification.user
    @line = line
    @subject = subject
    @message = message
    mail(
      :subject => "[遅延通知くん] <#{line}>【#{subject}】のため遅れる可能性があります",
      :return_path => Devise.mailer_sender,
      :to => notification.email
    )
  end

  def notify_confirmations(email, notification)
    @user = notification.user
    @url = approves_url(token: notification.token)
    mail(
      :subject => "[遅延通知くん] 通知先アドレスの確認",
      :return_path => Devise.mailer_sender,
      :to => email
    )
  end

end