require "test_helper"

class MailNotificationMailerTest < ActionMailer::TestCase
  test "mail_notification" do
    mail = MailNotificationMailer.mail_notification
    assert_equal "Mail notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
