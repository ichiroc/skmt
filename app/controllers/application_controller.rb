# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def not_permitted
    redirect_to root_url, alert: 'この操作は許可されていません'
  end
end
