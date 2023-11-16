class UserController < ApplicationController

  def index
    @users = User.where(:role => "fighter")
    render "users/index"
    
  end

  def show
    @user = User.find_by!(username: params.fetch(:username))
    render "users/show"
  end

  def carousel
    @fighter = current_user.users_not_swiped_on.sample
    render "users/carousel"
  end


  
end
