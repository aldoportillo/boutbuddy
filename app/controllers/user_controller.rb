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
    @fighter = User.where(:role => "fighter").sample ##Implement where :weight_class => current_user.weight_class
    render "users/carousel"
  end


  
end
