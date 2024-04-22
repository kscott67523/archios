class TestMailer < ApplicationMailer
  default from: "support@archios.cloud"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.hello.subject
  #
  def hello
    mail(
      subject: "Hello from Postmark",
      to: "support@archios.cloud",
      from: "support@archios.cloud",
      html_body: "received",
      track_opens: "true",
      message_stream: "outbound",
    )
  end
end
