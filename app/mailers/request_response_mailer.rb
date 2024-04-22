class RequestResponseMailer < ApplicationMailer
  def response_email(email)
    @recipient_email = email
    mail(to: @recipient_email, subject: 'Your request has been processed')
  end
end
