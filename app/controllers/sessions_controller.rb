class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.get_auth(:email, :password)
      session[:current_user_id] = @user.id
    else
      redirect_to root_url
    end
  end

  def destroy
    session.delete(:current_user_id)
    @current_user_id = nil
  end

end
