class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis
  end

  def update
  end
end
