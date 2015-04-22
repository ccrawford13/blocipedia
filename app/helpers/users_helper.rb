module UsersHelper

#Check whether user is a premium subscriber or an admin
  def premium_or_admin(user)
    if user.role == 'premium' || current_user.role == 'admin'
      true
    else
      false
    end
  end
      
end
