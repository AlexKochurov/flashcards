class ActiveAdmin::ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    @is_admin = @user.has_role? :admin
  end

  def index?
    @is_admin
  end

  def show?
    @is_admin #scope.where(id: record.id).exists?
  end

  def create?
    @is_admin
  end

  def new?
    create?
  end

  def update?
    @is_admin
  end

  def edit?
    update?
  end

  def destroy?
    @is_admin
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end