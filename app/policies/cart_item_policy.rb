# frozen_string_literal: true
class CartItemPolicy < ApplicationPolicy
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
