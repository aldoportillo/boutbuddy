class UserController < ApplicationController

  def index
    

    @q = User.where(:role => "fighter").order(:last_name).ransack(params[:q])
    @users = @q.result
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
