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

  describe '小計・合計' do
    before :each do
      @cart = cart
      @cart.items = Array.new(10) { build :cart_item }
      @cart.items.each do |item|
        item.product.price = 1000
      end
      @cart.save!
    end

    describe '小計金額' do
      it 'カート内の商品の小計金額を計算できること' do
        expect(@cart.subtotal).to eq 10_000
      end
    end

    describe '合計金額' do
      it 'カート内の商品の合計金額を計算できること' do
        #       小計 + 送料 + 代引き手数料
        total = ((10_000 + 1200 + 400 ) * 1.08).floor
        expect(@cart.total).to eq total
      end
    end
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

  describe '代引き手数料' do
    subject(:cod_fee){
      item = build :cart_item
      item.product = build :product, price: price
      cart.items << item
      cart.save!
      cart.cache_on_delivery_fee
    }
    context '0-10,000円未満' do
      let(:price) { 9999 }
      it { is_expected.to eq 300 }
    end
    context '10,000-30,000円未満' do
      let(:price) { 10_000 }
      it { is_expected.to eq 400 }
      let(:price) { 29_999 }
      it { is_expected.to eq 400 }
    end
    context '30,000-100,000円未満' do
      let(:price) { 30_000 }
      it { is_expected.to eq 600 }
      let(:price) { 99_999 }
      it { is_expected.to eq 600 }
    end
    context '100,000円以上' do
      let(:price) { 100_000 }
      it { is_expected.to eq 1000 }
    end
  end

  describe '税額' do
    subject(:tax_amount){
      item = build :cart_item
      product = build :product, price: price
      item.product = product
      cart.items << item
      cart.save!
      cart.tax_amount
    }
    let(:price){ 1000 }
    it 'カート内の商品の税額を計算できる' do
      # 小計 + 送料 + 代引き手数料
      tax = ((1000 + 600 + 300) * 0.08).floor
      is_expected.to eq tax
    end

    context '税額が少数になる場合' do
      let(:price){ 1001 }
      it '端数は切り捨てられる' do
        tax = ((1000 + 600 + 300) * 0.08).floor
        is_expected.to eq tax # Not 152.08
      end
    end
  end
end
