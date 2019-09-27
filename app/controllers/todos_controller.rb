class TodosController < ApplicationController
  def index
    auth_token
    @response = HTTParty.get(
      "http://localhost:3000/todos",
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "#{auth_token}"
      } 
    )
    @todo_list = @response.find{|h| h}.select{|s,v| s == "items"}.to_a[0][1]
    @enum = @response
    # @current_todo = Todo.find_by(title: todo['title'])
    # binding.pry
  end

  def show
    auth_token
    @response = HTTParty.get(
      "http://localhost:3000/todos/#{@current_todo}",
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "#{auth_token}"
      } 
    )
    @todo_list = @response
    # Above is only temporary
    # binding.pry
  end

  def new
    @todo = Todo.new
  end

  def create
    auth_token
    if @todo = todos_params
      @response = HTTParty.post(
        "http://localhost:3000/todos",
        body: {"title": "#{@todo[:title]}"}.to_json,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "#{auth_token}"
        } 
      )
      Todo.new(title: @response['title'], todo_id: @response['id']).save
      @current_todo = Todo.find_by(todo_id: @response['id'])
      redirect_to todo_path(@current_todo.id)
      # binding.pry
    else
      render 'new'
    end
  end

  private

  def auth_token
    Session.find_by(id: session[:current_user_id]).session_id
  end

  def todos_params
    params.permit(:title)
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
