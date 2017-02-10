# coding: utf-8
require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject(:order_item) { build :order_item }
  it{ is_expected.to be_valid }

  it 'バリデーション前にカート品目から情報が生成される' do
    order_item.valid?
    expect(order_item.price).to eq order_item.cart_item.product.price
    expect(order_item.product_name).to eq order_item.cart_item.product.name
    expect(order_item.quantity).to eq order_item.quantity
  end

end
