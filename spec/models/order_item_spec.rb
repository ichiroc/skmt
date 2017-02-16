# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject(:order_item) { build :order_item }
  it { is_expected.to be_valid }

  it 'オーダー品目の合計金額を計算できる' do
    order_item.product_price = 100
    order_item.quantity = 10
    expect(order_item.total).to eq 1000
  end

  describe '注文品目情報' do
    subject(:order_item) { build :order_item, cart_item: cart_item }

    context '初期化時にカート品目と関連付けがある場合' do
      let(:cart_item) { build :cart_item }
      it 'カート品目の情報が複製される' do
        order = build :order
        order_item = order.items.build cart_item: cart_item
        order_item.save!
        cart_item = order_item.cart_item
        expect(order_item.product_price).to eq cart_item.product.price
        expect(order_item.product_name).to eq cart_item.product.name
        expect(order_item.quantity).to eq order_item.quantity
      end
    end
    context '初期化時にカート品目と関連付けがなければ' do
      let(:cart_item) { nil }
      it '独自の値を持つ' do
        order_item = build :order_item
        order_item.product_name  = name     = 'hoge'
        order_item.product_price = price    = 100
        order_item.quantity      = quantity = 10
        order_item.save!
        expect(order_item.product_price).to eq price
        expect(order_item.product_name).to eq name
        expect(order_item.quantity).to eq quantity
      end
    end
  end

  describe '商品金額(product_price)' do
    subject(:product_price_error) {
      item = build :order_item, product_price: price
      item.valid?
      item.errors[:product_price]
    }
    context '空の場合' do
      let(:price) { nil }
      it { is_expected.to include t('errors.messages.blank') }
    end
    context '0円以下の場合' do
      let(:price) { 0 }
      it { is_expected.to include t('errors.messages.greater_than', count: 0) }
    end
  end

  describe '数量' do
    subject(:quantity_error){
      item = build :order_item, quantity: quantity
      item.valid?
      item.errors[:quantity]
    }
    context '空の場合' do
      let(:quantity) { nil }
      it { is_expected.to include t('errors.messages.blank') }
    end
    context '0以下の場合' do
      let(:quantity) { 0 }
      it { is_expected.to include t('errors.messages.greater_than', count: 0) }
    end
  end
end
