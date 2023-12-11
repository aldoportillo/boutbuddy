# ApplicationController is the main controller from which all other controllers inherit.
class ApplicationController < ActionController::Base
  # Skip the default Rails forgery protection
  skip_forgery_protection
  # Rescue from a Pundit::NotAuthorizedError with the user_not_authorized method
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Include Pundit's authorization methods
  include Pundit::Authorization
  # Before any action, configure the permitted parameters if it's a Devise controller
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # configure_permitted_parameters is a protected method that configures the parameters that Devise should permit
  def configure_permitted_parameters
    # Permit the first_name, last_name, photo, weight, reach, height, username, and role parameters for sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo, :weight, :reach, :height, :username, :role])
    # Permit the first_name, last_name, photo, weight, reach, height, username, and role parameters for account update
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo, :weight, :reach, :height, :username, :role])
  end

  private

  # user_not_authorized is a private method that sets a flash message and redirects the user when they are not authorized to perform an action
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
