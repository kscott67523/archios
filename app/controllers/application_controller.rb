class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  skip_forgery_protection
end
