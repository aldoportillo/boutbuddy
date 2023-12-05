class UserController < ApplicationController

  def index
    

    @q = User.where(:role => "fighter").order(:last_name).ransack(params[:q])
    @users = @q.result
    render "users/index"
    
  end

  def show
    @user = User.find_by!(username: params.fetch(:username))
    @user_wins_data = @user.win_bys.group(:name).count
    render "users/show"
  end

  def carousel

    @fighters = current_user.users_not_swiped_on
    
    session[:fighters] = @fighters.map(&:id) # Storing fighter IDs in session
    session[:index] = 0 # Initialize index

    @fighter = current_user.users_not_swiped_on.first

    render "users/carousel"
  end


  
end
