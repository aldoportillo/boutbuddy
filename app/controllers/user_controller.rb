# UserController is a controller that handles actions related to User resources.
class UserController < ApplicationController
  # GET /users
  # This action lists all users with the role "fighter", ordered by last name
  def index
    # Use Ransack to build a search query for users with the role "fighter", ordered by last name
    @q = User.where(:role => "fighter").order(:last_name).ransack(params[:q])
    # Execute the query and store the result
    @users = @q.result
    # Render the users index view
    render "users/index"
  end

  # GET /users/:username
  # This action shows a specific user and their win data
  def show
    # Find the user by username
    @user = User.find_by!(username: params.fetch(:username))
    # Get the user's win data, grouped by the name of the win
    @user_wins_data = @user.win_bys.group(:name).count
    # Render the users show view
    render "users/show"
  end

  # GET /users/carousel
  # This action shows a carousel of users that the current user has not swiped on
  def carousel
    # Get a random user that the current user has not swiped on
    @fighter = current_user.users_not_swiped_on.sample
    # Render the users carousel view
    render "users/carousel"
  end
end
