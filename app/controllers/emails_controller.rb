# app/controllers/emails_controller.rb
class EmailsController < ApplicationController
  def receive
    puts "Received an email: #{params}"

    sender = params["sender"]
    body_plain = params["body-plain"]

    #email = params.fetch[:email]
    @employee = Employee.where(email: sender)
    #request_body = params.fetch[:request_body]
    Request.new(email: @employee.email, request_body: body_plain)

    case (body - plain)
    when "clock in"
      if Request.save? && @employee.clocked_out?
        employee.clock_in
        response = "You have clocked in at #{Time.now}."
      else
        response = "You are already clocked in"
      end
    when "clock out"
      if Request.save? && @employee.clocked_in?
        employee.clock_out
        response = "You have clocked out at #{Time.now}."
      else
        response = "You are already clocked out"
      end
    else
      response = "Invalid command"
    end
  end

  def remind
  end
end
