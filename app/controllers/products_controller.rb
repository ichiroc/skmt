# frozen_string_literal: true
class ProductsController < ApplicationController
  before_action :set_product, only: :show

  def index
    @products = Product.where(status: :active).order(:sort_order).page(params[:page])
  end

  def show
    @product
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :hidden, :sort_order, :image)
  end
end
