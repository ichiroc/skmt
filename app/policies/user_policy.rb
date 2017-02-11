class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    @user.is_admin?
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
