class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.is_admin?
        scope.all
      else
        @user.orders
      end
    end
  end

  def index?
    true
  end

  def create?
    @user == @record.user
  end

  def confirmation?
    create?
  end

  def show?
    create? || @user.is_admin?
  end

  def edit?
    @user.is_admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
