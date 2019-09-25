class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = user_params
      response = HTTParty.post(
        "http://localhost:3000/signup",
        body: {"name": "#{@user[:name]}", "email": "#{@user[:email]}", "password": "#{@user[:password]}", "password_confirmation": "#{@user[:password_confirmation]}"}.to_json,
        headers: {
          'Content-Type' => 'application/json'
        } 
      )
      User.new(auth_token: response['auth_token']).save
      @session_id = User.find_by(auth_token: response['auth_token'])
      session[:current_user_id] = @session_id.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
