class UserController < ApplicationController

  def index
    @users = User.order('last-name ASC')
  end

  def show
    @user = User.find_by!(username: params.fetch(:username))
    render "users/show"
  end

end
