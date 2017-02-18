# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  helper_method :find_cart

  def default_url_options options = {}
    { locale: I18n.locale }.merge options
  end

  private

  def set_locale
    I18n.locale = params[:locale]
  end

  def find_cart
    if user_signed_in?
      current_user.cart
    else
      session_cart
    end
  end

  def session_cart
    return Cart.find session[:cart_id] if Cart.exists? session[:cart_id]
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def not_permitted
    redirect_to root_url, alert: t('errors.messages.not_permitted_operation')
  end
end
