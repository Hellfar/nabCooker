class MealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def validate?
    user
  end

  def favorite?
    user
  end

  def select_diet?
    user
  end

  def unselect_diet?
    user
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
