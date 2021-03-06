class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |user| user.to_clear_string }.join("\n")
  end

  def show
    id = params[:id]
    user = User.find(id)
    render plain: user.to_clear_string
  end

  def create
    user_name = params[:user_name]
    user_email = params[:user_email]
    user_password = params[:user_password]
    new_user = User.create!(
      user_name: user_name,
      user_email: user_email,
      user_password: user_password,
    )
    render plain: "Hey! welcome you registered successfully with an id #{new_user.id}"
  end

  def login
    check1 = params[:user_email]
    check2 = params[:user_password]
    user = User.find { |u| u.user_email == check1 }
    if user == nil
      render plain: "Incorrect credentials!! Try again"
    elsif user.user_password == check2
      render plain: "Your login is successful!! Welcome #{user.user_name}"
    else
      render plain: "Incorrect credentials!! Try again"
    end
  end
end
