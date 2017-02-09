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
  has_many :items, class_name: CartItem

  TAX_RATE = 0.08
  DELIVERY_CHARGE_UNIT_QUANTITY = 5
  DELIVERY_CHARGE_UNIT_PRICE = 600

  def total
    tax_excluded_total + tax_amount
  end

  def tax_amount
    (tax_excluded_total * TAX_RATE).floor
  end

  def tax_excluded_total
    subtotal + delivery_charge + cache_on_delivery_fee
  end

  def subtotal
    items.map(&:total).inject(:+) || 0
  end

  def delivery_charge
    # nil を 0 にしたいので to_i する
    div, mod = items.map(&:quantity).inject(:+).to_i.divmod DELIVERY_CHARGE_UNIT_QUANTITY
    div += 1 if mod.positive?
    div * DELIVERY_CHARGE_UNIT_PRICE
  end

  def cache_on_delivery_fee
    case subtotal
    when 0..9_999
      300
    when 10_000..29_999
      400
    when 30_000..99_999
      600
    else
      1000
    end
  end
end
