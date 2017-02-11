# == Schema Information
#
# Table name: order_items
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  product_id    :integer
#  product_name  :string
#  product_price :integer
#  quantity      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#

class OrderItem < ApplicationRecord
  attr_accessor :cart_item
  belongs_to :order
  belongs_to :product, optional: true

  validates :product_name, presence: true
  validates :product_price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  before_validation :copy_from_cart_item, unless: 'cart_item.blank?'

  def total
    product_price * quantity
  end

  private

  def copy_from_cart_item
    self.product_name = cart_item.product.name
    self.product_price = cart_item.product.price
    self.quantity = cart_item.quantity
  end
end
