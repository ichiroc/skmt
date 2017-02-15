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

  describe 'デフォルトの送り先を指定' do
    it 'デフォルトの送り先が設定されること' do
      order.with_default_destination
      user = order.user
      expect(order.destination_name).to eq user.name
      expect(order.destination_zip_code).to eq user.zip_code
      expect(order.destination_address).to eq user.address
    end
  end

  describe '注文の確定時' do
    before :each do
      @cart = create :cart_with_user
      @user = @cart.user
      cart_item = build(:cart_item)
      @quantity = cart_item.quantity
      @product_name = cart_item.product.name
      @cart.items << cart_item
      @order = @user.orders.build(cart: @cart).with_default_destination
      @order.save!
    end
    it 'カートを空にする' do
      expect(@cart.items.count).to eq 0
    end

    it 'カートの品目から注文品目が作成される' do
      item = @order.items.first
      expect(item.quantity).to eq @quantity
      expect(item.product_name).to eq @product_name
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

  describe '配達先を保存する' do
    before :each do
      order.remember_destination = remember_destination
      order.save!
    end
    context '配達先を保存するフラグがたっていたら' do
      let(:remember_destination) { true }
      it '注文確定時にユーザー情報に保存する' do
        user = order.user
        expect(user.name).to eq order.destination_name
        expect(user.zip_code).to eq order.destination_zip_code
        expect(user.address).to eq order.destination_address
      end
    end
    context '配達先を保存するフラグがたっていなければ' do
      let(:remember_destination) { false }
      it '注文確定時にユーザー情報に保存しない' do
        user = order.user
        expect(user.name).not_to eq order.destination_name
        expect(user.zip_code).not_to eq order.destination_zip_code
        expect(user.address).not_to eq order.destination_address
      end
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
      it { is_expected.to include t('errors.messages.zip_code') }
    end
    context '8桁以上の場合' do
      let(:zip_code){ '12345678' }
      it { is_expected.to include t('errors.messages.zip_code') }
    end
    context '数字以外の文字がある場合' do
      let(:zip_code){ 'hogefoo' }
      it { is_expected.to include t('errors.messages.zip_code') }
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
