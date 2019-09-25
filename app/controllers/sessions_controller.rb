class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    if @session = session_params
      response = HTTParty.post(
        "http://localhost:3000/auth/login",
        body: {"email": "#{@session[:email]}", "password": "#{@session[:password]}"}.to_json,
        headers: {
          'Content-Type' => 'application/json'
        } 
      )
      Session.new(session_id: response['auth_token']).save
      @session_id = Session.find_by(session_id: response['auth_token'])
      session[:current_user_id] = @session_id.id
      redirect_to todo_index_path
    else
      render 'new'
    end
  end

  def destroy
    delete_session
  end

  private

  def session_params
    params.permit(:email, :password)
  end

  def delete_session
    if logged_in = Session.find_by(id: session[:current_user_id])
      logged_in.destroy
      session.delete(:current_user_id)
      @current_user_id = nil
      redirect_to root_path
    elsif logged_in = User.find_by(id: session[:current_user_id])
      logged_in.destroy
      session.delete(:current_user_id)
      @current_user_id = nil
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

end
