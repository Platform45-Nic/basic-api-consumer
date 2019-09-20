class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    binding.pry
    @session = Session.new(session_params)
    if @session.save
      response = HTTParty.post(
        "http://localhost:3000/auth/login",
        body: {"email": "#{email.to_s}", "password": "#{password.to_s}"}.to_json,
        headers: {
          'Content-Type' => 'application/json'
        } 
      )
      response['auth_token']
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    session.delete(:current_user_id)
    @current_user_id = nil
  end

  private

  def session_params
    params
  end

end
