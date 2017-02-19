# coding: utf-8
# frozen_string_literal: true
class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update, :destroy]
  after_action :verify_authorized, except: :index

  def index
    # policy_scope でセッションのカートを扱うのが難しかったのでここだけ Pundit 除外
    @cart_items = find_cart.items.includes(:product)
  end

  def create
    product = Product.find(params[:product_id])
    @cart_item = authorize find_cart.items.find_or_initialize_by(product: product)
    @cart_item.quantity += 1
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to product, notice: 'Cart item was successfully created.' }
      else
        format.html { redirect_to product, alert: 'Cart item was not created.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to cart_items_path, notice: 'Cart item was successfully updated.' }
      else
        format.html { redirect_to cart_items_path, notice: 'Cart item was failed.' }
      end
    end
  end

  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: 'Cart item was successfully destroyed.' }
    end
  end

  private

  def set_cart_item
    @cart_item = authorize CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :product_id, :quantity)
  end
end
