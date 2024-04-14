class EmailSenderJob
  include Sidekiq::Job

  def perform

    incoming_email = JSON.parse(request.body.read)
    EmailProcessor.new(incoming_email).process
    
    head :ok
  end

end
