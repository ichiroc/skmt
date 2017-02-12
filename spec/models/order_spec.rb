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
    order.copy_data_from_cart!
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

  describe '配達時間帯' do
    subject(:error_messsage){
      order.delivery_time_zone = delivery_time_zone
      order.valid?
      order.errors[:delivery_time_zone]
    }
    context '空の場合' do
      let(:delivery_time_zone){ nil }
      it { is_expected.to include t('errors.messages.blank') }
    end
  end

  describe '配達氏名' do
    subject(:error_messsage){
      order.destination_name = destination_name
      order.valid?
      order.errors[:destination_name]
    }
    context '空の場合' do
      let(:destination_name){ nil }
      it { is_expected.to include t('errors.messages.blank') }
    end
  end

  describe '配達先郵便番号' do
    let(:order){ build :order, destination_zip_code: zip_code }
    subject(:error_messsage){
      order.valid?
      order.errors[:destination_zip_code]
    }
    context '空の場合' do
      let(:zip_code){ nil }
      it { is_expected.to include t('errors.messages.blank') }
    end
    context '6桁以下の場合' do
      let(:zip_code){ '123456' }
      it { is_expected.to include t('errors.messages.invalid') }
    end
    context '8桁以上の場合' do
      let(:zip_code){ '12345678' }
      it { is_expected.to include t('errors.messages.invalid') }
    end
    context '数字以外の文字がある場合' do
      let(:zip_code){ 'hogefoo' }
      it { is_expected.to include t('errors.messages.invalid') }
    end
    context 'ハイフンが含まれている場合' do
      let(:zip_code){ '123-4567' }
      it 'ハイフンが除去されること' do
        order.valid?
        expect(order.destination_zip_code).to eq '1234567'
      end
    end
  end

  describe '配達先住所' do
    subject(:error_messsage){
      order.destination_address = destination_address
      order.valid?
      order.errors[:destination_address]
    }
    context '空の場合' do
      let(:destination_address){ nil }
      it { is_expected.to include t('errors.messages.blank') }
    end
  end
end
