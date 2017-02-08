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
      cart.items = Array.new(10) { build :cart_item }
      cart.save!
      total = (cart.items.map(&:total).inject(:+) * 1.08).floor + 1200
      expect(cart.total).to eq total
    end

    describe '配達料' do
      subject(:delivery_charge) {
        cart.items = Array.new(amount) { build :cart_item }
        cart.save!
        cart.delivery_charge
      }
      context '5個の場合' do
        let(:amount) { 5 }
        it { is_expected .to eq 600 }
      end
      context '6個の場合' do
        let(:amount) { 6 }
        it { is_expected .to eq 1200 }
      end
      context '10個の場合' do
        let(:amount) { 10 }
        it { is_expected .to eq 1200 }
      end
      context '11個の場合' do
        let(:amount) { 11 }
        it { is_expected .to eq 1800 }
      end
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
