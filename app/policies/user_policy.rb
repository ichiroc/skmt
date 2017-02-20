class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.is_admin?
        scope.all
      else
        scope.none
      end
    end
  end

  def manage?
    return false if @user.blank?
    @user.is_admin?
  end

  def index?
    manage?
  end

  def show?
    index?
  end

  def edit
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end
end
