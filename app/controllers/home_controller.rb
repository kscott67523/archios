# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # what is the purpose of @name ?
    @name = "so you don't lose track of time."
  end
end
