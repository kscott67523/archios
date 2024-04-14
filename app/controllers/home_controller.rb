# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @name = 'Simple migration system.'
    @message = 'This application helps manage timesheets, projects, and employee data efficiently.'
  end
end
