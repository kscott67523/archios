# frozen_string_literal: true

class ApplicationController < ActionController::Base
  #before_action :authenticate_employee!, only: %i[show edit update destroy]
  skip_forgery_protection

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Employee)
      employee_path(resource)
    else
      super
    end
  end
end
