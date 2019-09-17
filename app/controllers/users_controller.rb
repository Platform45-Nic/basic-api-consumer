class UsersController < ApplicationController
  def index
    # binding.pry
    @user = HTTParty.get('http://localhost:3000/todos/1/', :headers =>{'Content-Type' => 'application/json', 'Authorization' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Njg3MzI0NDd9.1TN_Rp1XyFNYuGJMZrqiwJnXWu9vyXHWM_k4esn_DvM'} )
    @user1 = HTTParty.get('http://localhost:3000/todos/2/items/5', :headers =>{'Content-Type' => 'application/json', 'Authorization' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Njg3MzI0NDd9.1TN_Rp1XyFNYuGJMZrqiwJnXWu9vyXHWM_k4esn_DvM'} )
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  private

  def user_params
    params.permit(:auth_token)
  end
end
