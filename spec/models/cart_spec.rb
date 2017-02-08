# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Cart, type: :model do
  subject(:cart) { build :cart }

  it { is_expected.to be_valid }

  it 'カートに商品を追加出来ること' do
    expect do
      cart.items << build(:cart_item)
      cart.save
    end.to change(cart.items, :count).by(+1)
  end

  describe '計算' do
    it 'カート内の商品の合計金額を計算できること' do
      items = Array.new(10) { build :cart_item }
      cart.items = items
      total = (items.map(&:total).inject(:+) * 1.08).floor
      expect(cart.total).to eq total
      # 念のため
      cart.items = []
      i1 = build :cart_item
      i2 = build :cart_item
      cart.items << i1
      cart.items << i2
      total = ((i1.total + i2.total) * 1.08).floor
      expect(cart.total).to eq total
    end

    describe '税計算' do
      it 'カート内の商品の税額を計算できる' do
        i1 = build :cart_item
        i2 = build :cart_item
        cart.items << i1
        cart.items << i2
        tax = ((i1.total + i2.total) * 0.08).floor
        expect(cart.tax_amount).to eq tax
      end

      context '少数の場合' do
        it '端数は切り捨てられる' do
          item = build :cart_item
          item.product = build :product, price: 10
          cart.items << item
          expect(cart.total).to eq 10 # -> Not 10.8
        end
      end
    end
  end
end
