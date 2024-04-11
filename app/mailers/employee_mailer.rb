class EmployeeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.employee_mailer.Welcome.subject
  
  def welcome
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
