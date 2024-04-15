class ErrorsController < ApplicationController
  def not_found
    render './app/views/errors/error', status: :not_found, locals: { error_message: "The page you are looking for doesn't exist." }
  end
end
