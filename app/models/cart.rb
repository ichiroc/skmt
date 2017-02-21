# coding: utf-8
# frozen_string_literal: true
# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#

class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items, class_name: CartItem, dependent: :destroy

  TAX_RATE = 0.08

  DELIVERY_FEE_UNIT_QUANTITY = 5
  DELIVERY_FEE_UNIT_PRICE = 600

  COD_TOTAL_PRICE_RANGE1 = 0..9_999
  COD_FEE_LEVEL1 = 300

  COD_TOTAL_PRICE_RANGE2 = 10_000..29_999
  COD_FEE_LEVEL2 = 400

  COD_TOTAL_PRICE_RANGE3 = 30_000..99_999
  COD_FEE_LEVEL3 = 600

  COD_FEE_LEVEL4 = 1000

  def total
    tax_excluded_total + tax_amount
  end

  def tax_amount
    (tax_excluded_total * TAX_RATE).floor
  end

  def tax_excluded_total
    subtotal + delivery_fee + cache_on_delivery_fee
  end

  def subtotal
    items.map(&:total).inject(:+) || 0
  end

  def delivery_fee
    div, mod = items.sum(:quantity).divmod DELIVERY_FEE_UNIT_QUANTITY
    div += 1 if mod.positive?
    div * DELIVERY_FEE_UNIT_PRICE
  end

  def cache_on_delivery_fee
    case subtotal
    when COD_TOTAL_PRICE_RANGE1
      COD_FEE_LEVEL1
    when COD_TOTAL_PRICE_RANGE2
      COD_FEE_LEVEL2
    when COD_TOTAL_PRICE_RANGE3
      COD_FEE_LEVEL3
    else
      COD_FEE_LEVEL4
    end
  end

  def empty!
    items.destroy_all
  end
end
