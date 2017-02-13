# coding: utf-8
require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) { build :order }
  it { is_expected.to be_valid }

  describe 'カート情報の転記' do
    it '初期化時にカートから注文情報を生成されること' do
      cart = build :cart_with_user
      cart.items << build(:cart_item)
      # build では new の時になんの引数も渡さないらしいので素の new を使う
      order = Order.new cart: cart
      expect(order.total).to eq cart.total
      expect(order.tax_amount).to eq cart.tax_amount
      expect(order.delivery_fee).to eq cart.delivery_fee
      expect(order.cache_on_delivery_fee).to eq cart.cache_on_delivery_fee
      expect(order.subtotal).to eq cart.subtotal
    end
  end

  describe '配達時間帯' do
    subject(:error_messsage){
      order.delivery_time_slot = delivery_time_slot
      order.valid?
      order.errors[:delivery_time_slot]
    }
    context '空の場合' do
      let(:delivery_time_slot){ nil }
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
