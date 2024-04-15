# app/controllers/emails_controller.rb
class EmailsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    puts "Received an email: #{params}"

    sender = params["sender"]
    body_plain = params["body-plain"]

    @employee = Employee.find_by(email: sender)
    return head(:not_found) unless @employee

    request = Request.new(email: @employee.email, request_body: body_plain)
    request.save

    response = case body_plain.downcase.strip
               when "clock in"
                 handle_clock_in
               when "clock out"
                 handle_clock_out
               else
                 "Invalid command"
               end

    render plain: response
  end

  private

  def handle_clock_in
    if @employee.clocked_out?
      @employee.clock_in
      "You have clocked in at #{Time.now}."
    else
      "You are already clocked in."
    end
  end

  def handle_clock_out
    if @employee.clocked_in?
      @employee.clock_out
      "You have clocked out at #{Time.now}."
    else
      "You are already clocked out."
    end
  end
end
