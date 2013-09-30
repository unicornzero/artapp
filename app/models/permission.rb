class Permission

  def initialize(user)
  	@user = user
    allow :users, [:new, :create, :index]
    allow :spaces, [:index, :show]
    allow :photos, [:show]
    #sessions and other things
    if user
      allow_all if user.superadmin
      allow :spaces, [:edit, :update] do |space|
        space.user_id == user.id
      end
      allow :photos, [:create, :edit, :update, :destroy] do |space|
        space.user_id == user.id
      end
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end

  def old_allow?(controller, action, resource=nil)
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

  def allow_all
    @allow_all = true
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end
end