# frozen_string_literal: true
class OrdersController < ApplicationController
  include Pundit
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @orders = policy_scope(Order).page
  end

  def show
  end

  def new
    @order = authorize current_user.orders.build cart: find_cart
  end

  def edit
  end

  def create
    @order = authorize current_user.orders.build(order_params.merge(cart: find_cart))
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
    end
  end

  private

  def set_order
    @order = authorize Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id,
                                  :total,
                                  :tax_amount,
                                  :delivery_fee,
                                  :cache_on_delivery_fee,
                                  :delivery_time_slot,
                                  :delivery_date,
                                  :destination_name,
                                  :destination_zip_code,
                                  :destination_address,
                                  :remember_destination)
  end
end
