class UserController < ApplicationController

  def index
    @users = User.all
    render "users/index"
    
  end

  def show
    @user = User.find_by!(username: params.fetch(:username))
    render "users/show"
  end


  
end
