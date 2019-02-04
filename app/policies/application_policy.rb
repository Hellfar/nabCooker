class ApplicationPolicy
  attr_reader :user, :record

  def initialize(context, record)
    @context = context
    @user = context.user
    @params = context.params
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(@context, @record.class)
  end

  class Scope
    attr_reader :user, :params, :scope

    def initialize(context, scope)
      @user = context.user
      @params = context.params
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
