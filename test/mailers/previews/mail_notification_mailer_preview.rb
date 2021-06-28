# Preview all emails at http://localhost:3000/rails/mailers/mail_notification_mailer
class MailNotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mail_notification_mailer/mail_notification
  def mail_notification
    MailNotificationMailer.mail_notification
  end

end
