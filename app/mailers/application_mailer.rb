class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEFAULT_HOST']
  layout 'mailer'
end
