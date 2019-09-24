class TodosController < ApplicationController
  def index
    auth_token = Session.find_by(id: session[:current_user_id]).session_id
    @response = HTTParty.get(
      "http://localhost:3000/todos",
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "#{auth_token}"
      } 
    )
    @todo_list = @response.find{|h| h}.select{|s,v| s == "items"}.to_a[0][1]
  end

  def new
  end

  def create
  end

  private

  def todos_params
    params.permit(:email, :password)
  end

  def delete_todo
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
