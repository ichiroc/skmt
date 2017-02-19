class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def manage?
    return false if @user.blank?
    @user.is_admin?
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user.is_admin?
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
