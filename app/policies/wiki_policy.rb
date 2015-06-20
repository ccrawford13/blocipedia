class WikiPolicy < ApplicationPolicy


  def index?
    true
  end

  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
      if user
         wikis = []
         if user.role == 'admin'
            wikis = scope.all # if the user is an admin, show them all the wikis
         else user.role == 'premium'
           all_wikis = scope.all
           all_wikis.each do |wiki|
             if wiki.public? || wiki.user == user || wiki.collaborators.include?(user)
               wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
             end
           end
         end
       else # standard/guest user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.public? || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on - guest users will have no callaborations
           end
         end
         wikis # return the wikis array
       end
     end

   end
end
