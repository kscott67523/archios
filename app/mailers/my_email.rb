# app/mailers/my_email.rb
class MyEmail < Griddler::Email
  def initialize(email)
    super(email)
  end

  def sent_at
    # Assuming the email service provider includes a 'Date' header with the send timestamp
    # This header is standard in emails but check your provider's documentation for specifics
    Time.parse(headers[:date])
  rescue
    nil  # Return nil if there is an error parsing the date
  end
end
