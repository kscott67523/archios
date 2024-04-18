class EmailProcessor
  attr_reader :email

  def initialize(email)
    @email = email
  end

  def process
    if verify_employee(sender_email)
      begin
        Request.create!(
          request_body: email.body,
          sender_email: sender_email,
        )
        Rails.logger.info "Request processed successfully."
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error "Failed to process request: #{e.message}"
        handle_processing_failure("We're sorry, but we were unable to process your request. Please try again.")
      end
    else
      handle_processing_failure("Unauthorized request attempt detected.")
    end
  end

  def handle_processing_failure(message)
    Rails.logger.error message
    # Additional failure handling here.
  end

  def sender_email
    email.from[:email]
  end

  def body
    email.body
  end

  private

  def verify_employee(email_address)
    Employee.exists?(email: email_address)
  end
end
