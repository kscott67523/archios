# config/initializers/postmark.rb

Postmark.configure do |config|
  # Set the Postmark API token from environment variable
  config.api_token = ENV['POSTMARK_API_KEY']

  # Set the inbound email hash from environment variable or hardcoded value
  Rails.application.config.postmark_inbound_email_hash = ENV['POSTMARK_INBOUND_EMAIL_HASH'] || '5b0c75c112b606889bc59936d3427461'
end
