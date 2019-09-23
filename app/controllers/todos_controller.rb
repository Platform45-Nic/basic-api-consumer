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
    binding.pry
  end

end
