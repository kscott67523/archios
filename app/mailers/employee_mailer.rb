class EmployeeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.employee_mailer.Welcome.subject
  #
  def welcome
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end

#employee controller
after create commit send_welcome

private 
def send_welcome
Employee.mailer.with user:self.welcome.deliver_now
end


#mailer 
Employee.mailer.with user:params[user].welcome.deliver_now

#background job
#good_job

mount blazer::engine => employee/admin
railsadmin
mount goodjob::engine => employee/admin
