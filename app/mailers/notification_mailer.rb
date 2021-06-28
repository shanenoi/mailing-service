class NotificationMailer < ApplicationMailer

  def convert_key_str_to_string(args)
    result = {}
    args.map do |key, value|
      result[key.to_sym] = value
    end
    result
  end

  def notification(args)
    form = MailForm.find(args[:id])

    @args = {
      subject: format(form.subject, convert_key_str_to_string(args[:subject])),
      content: format(form.content, convert_key_str_to_string(args[:content]))
    }
    mail(to: args[:email], subject: @args[:subject])
  end
end
