class Permission

  def initialize(user)
  	@user = user
  end

  def allow?(controller, action, resource=nil)
    #user && user.super_admin?
    user = @user
    if user.nil?
      controller == "users" && action == "index"
    elsif user.superadmin
      true
    elsif controller == "spaces" && action == "edit" && resource
      space = Space.find(resource)
      if space.user_id && space.user_id == user.id
      	true
      else
      	false
      end
    elsif controller == "spaces" && action == "update" && resource
      space = Space.find(resource)
      if space.user_id && space.user_id == user.id
      	true
      else
      	false
      end
    elsif controller == "photos" && action == "edit" && resource
      if resource.space_id && Space.find(resource.space_id).user_id == user.id
      	true
      else
      	false
      end
    elsif controller == "photos" && action == "update" && resource
      if resource.space_id && Space.find(resource.space_id).user_id == user.id
      	true
      else
      	false
      end
    else
      controller == "users" && action == "index"
    end
  end
end