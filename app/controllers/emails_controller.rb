class EmailsController < ApplicationController
  #skip_before_action :verify_authenticity_token

  def receive
    email_params = params[:email]

    sender = email_params[:from]
    subject = email_params[:subject]
    request_body = email_params[:plain_text]

    request = Request.create(
      sender: sender,
      request_body: request_body,
    )

    if request.persisted?
      # Respond to the email sender or return a response
      render plain: "Email received and saved successfully"
    else
      # Handle the case where the record could not be saved
      render plain: "Error saving email record", status: :unprocessable_entity
    end
  end
end
