class UsersController < ApplicationController
  def index
    @user = HTTParty.get('http://localhost:3000/todos', format: :plain, :headers =>{'Content-Type' => 'application/json', 'Authorization' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1Njg0NTc1OTR9.-0uSVXSSQQsI2a6PmCKzQutn6v5hYyrfGZeJmiYtdcY'} )
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
