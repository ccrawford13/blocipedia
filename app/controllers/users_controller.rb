class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis.public_wikis(@user)
    @private_wikis = Wiki.private_wikis(@user)
  end

  def update
  end
end
