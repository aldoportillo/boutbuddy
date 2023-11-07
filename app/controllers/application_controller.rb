class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo_url, :weight, :reach, :height, :username, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo_url, :weight, :reach, :height, :username, :role])
  end
end
