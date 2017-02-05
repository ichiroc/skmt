# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :find_cart
  private

  def find_cart
    if user_signed_in?
      current_user.cart
    else
      session_cart
    end
  end

  def session_cart
    if session[:cart_id]
      Cart.find session[:cart_id]
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end

  def not_permitted
    redirect_to root_url, alert: 'この操作は許可されていません'
  end
end
