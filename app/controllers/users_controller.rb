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
    Wiki.private_wikis(current_user).update_all(private: false)
    current_user.update_attributes(role: 'standard')
    redirect_to edit_user_registration_path
  end
end
