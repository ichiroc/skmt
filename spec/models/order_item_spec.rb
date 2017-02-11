# coding: utf-8
require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject(:order_item) { build :order_item }
  it { is_expected.to be_valid }

  describe '注文品目情報' do
    before :each do
      order_item.cart_item = cart_item
    end
    context 'カート品目と関連付けがあれば' do
      let(:cart_item){ build :cart_item }
      it 'バリデーション前にカート品目から情報が生成される' do
        order_item.valid?
        cart_item = order_item.cart_item
        expect(order_item.product_price).to eq cart_item.product.price
        expect(order_item.product_name).to eq cart_item.product.name
        expect(order_item.quantity).to eq order_item.quantity
      end
    end
    context 'カート品目と関連付けがなければ' do
      let(:cart_item) { nil }
      it 'バリデーション後も独自の値を持つ' do
        order_item.product_name  = name     = 'hoge'
        order_item.product_price = price    = 100
        order_item.quantity      = quantity = 10

        order_item.valid?

        expect(order_item.product_price).to eq price
        expect(order_item.product_name).to eq name
        expect(order_item.quantity).to eq quantity
      end
    end
  end


  it 'オーダー品目の合計金額を計算できる' do
    order_item.valid?
    expect(order_item.total).to eq order_item.cart_item.total
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
