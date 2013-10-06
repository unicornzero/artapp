class Permission

  def initialize(user)
  	@user = user
    allow :users, [:new, :create, :index]
    allow :spaces, [:index, :show]
    allow :photos, [:show]
    if user
      allow_all if user.superadmin
      allow :users, :show
      allow :spaces, [:edit, :update] do |space|
        space.user_id == user.id
      end
      allow :photos, [:new, :create, :edit, :update, :destroy] do |space|
        space.user_id == user.id
      end
      allow :subscriptions, [:index, :new, :create] do |space|
        space.user_id == user.id
      end
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
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