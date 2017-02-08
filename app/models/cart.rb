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

  def total
    tax_excluded_total + tax_amount
  end

  def tax_amount
    (tax_excluded_total * TAX_RATE).to_i
  end

  def tax_excluded_total
    items.map(&:total).inject(:+)
  end
end
