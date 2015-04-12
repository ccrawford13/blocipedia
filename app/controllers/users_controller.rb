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

  def downgrade_account
    current_user.update_attributes(role: 'standard')
    Wiki.private_wikis(@user).destroy_all
    redirect_to edit_user_registration_path
  end
end
