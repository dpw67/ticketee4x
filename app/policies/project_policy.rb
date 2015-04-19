class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def show?
    record.roles.exists?(user_id: user)
    
    user.try(:admin?) || record.roles.exists?(user_id: user)
  end
  
end
