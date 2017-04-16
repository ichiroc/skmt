# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  product_id :integer
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_cart_items_on_cart_id     (cart_id)
#  index_cart_items_on_product_id  (product_id)
#

class CartItem < ApplicationRecord
  belongs_to :cart, optional: false
  belongs_to :product, optional: false
  validates :quantity, numericality: { greater_than: 0 }

  delegate :name, to: :product
  delegate :price, to: :product
  delegate :image, to: :product

  def total
    product.price * quantity
  end
end
