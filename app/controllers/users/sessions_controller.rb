# coding: utf-8
class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  # ユーザーが未ログインの状態でカートに商品を入れていた場合はそのカートを優先する
  after_action :set_session_cart, only: [:create], if: ->{ session_cart.items.count.positive? }

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def set_session_cart
    current_user.cart.destroy
    current_user.cart = session_cart
  end
end
