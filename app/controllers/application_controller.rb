class ApplicationController < ActionController::Base
  protect_from_forgery
  # Include for sessions
  include SessionsHelper
end
