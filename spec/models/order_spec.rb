# coding: utf-8
require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) { build :order }
  it { is_expected.to be_valid }
  it 'カートから注文情報を生成されること' do
    cart = build :cart
    cart.items = Array.new(10){ build :cart_item }
    cart.save!
    order.cart = cart
    order.valid?
    expect(order.total).to eq cart.total
    expect(order.tax_amount).to eq cart.tax_amount
    expect(order.delivery_fee).to eq cart.delivery_fee
    expect(order.cache_on_delivery_fee).to eq cart.cache_on_delivery_fee
  end

  it '注文品目から小計を計算できる' do
    cart = build :cart
    cart.items << build( :cart_item, product: build(:product, price: 100), quantity: 5 )
    cart.save!
    order.cart = cart
    order.valid?
    expect(order.subtotal).to eq 500
  end
  it '配達時間帯は必須'
  it '配達先氏名は必須'
  it '配達先郵便番号は必須'
  it '配達先郵便番号は7桁の数字'
  it '配達先郵便番号にハイフンが含まれていたら除去する'
  it '配達先住所は必須'
end
