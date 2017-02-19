# coding: utf-8
# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  helper_method :find_cart

  def default_url_options(options = {})
    options.merge(locale: I18n.locale)
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
    if Cart.exists? session[:cart_id]
      cart = Cart.find session[:cart_id]
      return cart if Cart.user.blank?
    end
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def not_permitted
    redirect_to root_url, alert: t('errors.messages.not_permitted_operation')
  end
end
