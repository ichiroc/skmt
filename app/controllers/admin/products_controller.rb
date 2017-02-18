# frozen_string_literal: true
class Admin::ProductsController < ApplicationController
  include Pundit
  before_action :authenticate_user!
  before_action :not_permitted, unless: 'current_user.is_admin?'
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @products = policy_scope(Product).order(:sort_order).page(params[:page])
  end

  def show
  end

  def new
    @product = authorize Product.new
  end

  def edit
  end

  def create
    @product = authorize Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to [:admin, @product], notice: 'Product was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to [:admin, @product], notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Product was successfully destroyed.' }
    end
  end

  private

  def set_product
    @product = authorize Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :status, :sort_order, :image)
  end
end
