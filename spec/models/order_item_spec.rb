# coding: utf-8
require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject(:item) { build :order_item }
  it{ is_expected.to be_valid }

  it 'バリデーション前にカート品目から情報が生成される' do
    item.valid?
    cart_item = item.cart_item
    expect(item.product_price).to eq cart_item.product.price
    expect(item.product_name).to eq cart_item.product.name
    expect(item.quantity).to eq item.quantity
  end

  it 'オーダー品目の合計金額を計算できる' do
    item.valid?
    expect(item.total).to eq item.cart_item.total
  end

  describe '商品金額(product_price)' do
    it '必須である'
    it '0以下だとエラー'
  end

  describe '数量' do
    it '必須である'
    it '0以下だとエラー'
  end
end
