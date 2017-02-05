# frozen_string_literal: true
class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_permitted, unless: 'current_user.is_admin?'
  before_action :set_admin_product, only: [:show, :edit, :update, :destroy]

  def index
    @admin_products = Product.all
  end

  def show
  end

  def new
    @admin_product = Product.new
  end

  def edit
  end

  def create
    @admin_product = Product.new(admin_product_params)

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to [:admin, @admin_product], notice: 'Product was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_product.update(admin_product_params)
        format.html { redirect_to [:admin, @admin_product], notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @admin_product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Product was successfully destroyed.' }
    end
  end

  private

  def set_admin_product
    @admin_product = Product.find(params[:id])
  end

  def admin_product_params
    params.require(:product).permit(:name, :description, :price, :hidden, :sort_order, :image)
  end
end
