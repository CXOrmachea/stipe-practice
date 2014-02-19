class ApplicationController < ActionController::Base
  protect_from_forgery

# SPINACH you can do a before_filter for every controller action
  before_filter :authenticate_user!
end
