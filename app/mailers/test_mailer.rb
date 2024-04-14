class TestMailer < ApplicationMailer
  default from: "t-mail@archios.cloud"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.hello.subject
  #
  def hello
    mail(
      subject: "Hello from Postmark",
      to: "5b0c75c112b606889bc59936d3427461@inbound.postmarkapp.com",
      from: "t-mail@archios.cloud",
      html_body: "clock in",
      track_opens: "true",
      message_stream: "outbound",
    )
  end
end
