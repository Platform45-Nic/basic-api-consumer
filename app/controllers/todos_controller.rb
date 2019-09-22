class TodosController < ApplicationController
  def index
    auth_token = Session.find_by(id: session[:current_user_id])
    @response = HTTParty.get(
      "http://localhost:3000/todos",
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "#{auth_token}"
      } 
    )
  end

  def show
  end

end
