class CartItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    @user == @record.cart.user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
